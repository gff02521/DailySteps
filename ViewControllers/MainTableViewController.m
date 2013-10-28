//
//  MainTableViewController.m
//  Act
//
//  Created by Shinya Matsuyama on 10/28/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "MainTableViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DailyStepsCell.h"

@interface MainTableViewController ()
@property (strong, nonatomic) CMStepCounter *stepCounter;
@property (strong, nonatomic) NSMutableArray *cellDataArray;
@property (strong, nonatomic) NSOperationQueue *queryQueue;
@end

@implementation MainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //  StatusBarを表示
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    //  Navigationのバーを表示
    [self.navigationController.navigationBar setBarTintColor:[UIApplication sharedAppDelegate].darkColor];
    [self.navigationController.navigationBar setTintColor:[UIApplication sharedAppDelegate].textColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //  戻るボタンを表示しない
    self.navigationItem.hidesBackButton = YES;
    
    //  タイトルを指定
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 240.0, 44.0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIApplication sharedAppDelegate].textColor;
    titleLabel.font = [UIApplication sharedAppDelegate].naviTitleFont;
    titleLabel.text = @"Daily Steps";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //  背景色を決める
    self.view.backgroundColor = [UIApplication sharedAppDelegate].darkColor;
    
    //  tableView系の初期化
    [self setupTableView];
    
    //  StepCounterのセットアップ
    [self setupStepCounter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setupTableView
{
    //  表示するセルのデータを保管するArrayを作る
    _cellDataArray = [NSMutableArray array];
}

- (void)setupStepCounter
{
    //  ここに来てる時点でM7が搭載されてるけど一応条件分岐
    if([CMStepCounter isStepCountingAvailable] && _stepCounter == nil)
    {
        //  stepCounterを作る
        _stepCounter = [[CMStepCounter alloc] init];
        
        //  クエリのQueueを作る
        _queryQueue = [[NSOperationQueue alloc] init];
        
        //  データの取得を開始する
        [self startQuery];
    }
}

#pragma mark - Utility

- (NSString*)dateToYearMonthDayString:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    
    return [formatter stringFromDate:date];
}

- (NSDate*)todayZeroTimeDate
{
    NSDate *nowDate = [NSDate date];
    
    NSDateComponents *comps;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    comps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:nowDate];
    
    //  00:00:00にセット
    comps.hour = 0;
    comps.minute = 0;
    comps.second = 0;
    NSDate *today = [calendar dateFromComponents:comps];
    
    return today;
}

- (void)addCellData:(NSDictionary*)dic
{
    [_cellDataArray addObject:dic];
    [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:_cellDataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Query

- (void)startQuery
{
    //  今日を最初にして一週間分遡るやりかた
    
    //  今日の日付の0:00のNSDateを作る
    NSDate *todayZeroDate = [self todayZeroTimeDate];
    
    //  リクエストをバックグラウンドで実行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            [self queryStepCountingFromDate:todayZeroDate todayDate:todayZeroDate];
        }
    });
}

- (void)queryStepCountingFromDate:(NSDate*)fromdate todayDate:(NSDate*)todayDate
{
    //  fromから丸1日分のデータを取る
    
    //  指定時間刻みでデータを取得する
    NSTimeInterval interval = 60.0*30.0;    //  30分刻み
    
    //  クエリの回数
    NSInteger queryNum = 60.0*60.0*24.0/interval;
    
    //  クエリループ
    NSMutableArray *oneDayArray = [NSMutableArray array];
    __block NSInteger count = 0;
    
    for(NSInteger i=0;i<queryNum;i++)
    {
        NSDate *from = [fromdate dateByAddingTimeInterval:i*interval];
        NSDate *to = [from dateByAddingTimeInterval:interval];
        
        [_stepCounter queryStepCountStartingFrom:from to:to toQueue:_queryQueue withHandler:^(NSInteger numberOfSteps, NSError *error) {
            //  データが来たら
            count++;
            if(error == nil)
            {
                NSDictionary *dic = @{ @"from":from, @"to":to, @"steps":@(numberOfSteps) };
                //NSLog(@"addObject:%@", dic);
                [oneDayArray addObject:dic];
            }
            else
            {
                NSLog(@"error:%@", [error description]);
            }
        }];
    }
    
    //  クエリが完了するまで待つ
    while(count < queryNum);
    
    //  ソートしておく
    [oneDayArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //
        NSDictionary *dic1 = obj1;
        NSDictionary *dic2 = obj2;
        
        NSDate *date1 = dic1[@"from"];
        NSDate *date2 = dic2[@"from"];
        
        return [date1 compare:date2];
    }];
    
    //  歩数を集計
    NSInteger steps = 0;
    for(NSDictionary *dic in oneDayArray)
    {
        NSNumber *stepsNum = dic[@"steps"];
        steps += stepsNum.integerValue;
    }
    
    //  グラフに使えるデータとして追加
    NSDictionary *dic = @{ @"graphArray":oneDayArray, @"date":fromdate, @"steps":@(steps) };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            [self addCellData:dic];
            
            NSLog(@"graphNum:%d", (int)oneDayArray.count);
        }
    });
    
    //  一週間さかのぼってなければ一日前をリクエスト
    NSTimeInterval dTime = [fromdate timeIntervalSinceDate:todayDate];
    if(dTime > -(60.0*60.0*24.0*7))
    {
        [self queryStepCountingFromDate:[fromdate dateByAddingTimeInterval:-60.0*60.0*24.0] todayDate:todayDate];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DailyStepsCell";
    DailyStepsCell *cell = (DailyStepsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //
    NSDictionary *dic = _cellDataArray[indexPath.row];
    
    //
    NSInteger stepsSum = [dic[@"steps"] integerValue];
    NSDate *date = dic[@"date"];
    NSArray *graphArray = dic[@"graphArray"];
    
    [cell setDate:date];
    [cell setSteps:stepsSum];
    [cell setGraphData:graphArray forKey:@"steps"];
    
    NSInteger row = indexPath.row;
    if(row%2)
        cell.contentView.backgroundColor = [UIApplication sharedAppDelegate].lightColor;
    else
        cell.contentView.backgroundColor = [UIApplication sharedAppDelegate].lightDownColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DailyStepsCell cellHeight];
}

@end
