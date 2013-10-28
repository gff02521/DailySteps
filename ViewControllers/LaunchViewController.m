//
//  LaunchViewController.m
//  Act
//
//  Created by Shinya Matsuyama on 10/28/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "LaunchViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  StatusBarを消す
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    //  Navigationのバーを消す
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //  背景色を決める
    self.view.backgroundColor = [UIApplication sharedAppDelegate].darkColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //  表示が完了したらM7チップがあるかどうか調べて、画面遷移する
    if([CMStepCounter isStepCountingAvailable] && [CMMotionActivityManager isActivityAvailable])
    {
        //  M7がある
        [self performSegueWithIdentifier:@"toMainTableView" sender:self];
    }
    else
    {
        //  M7が使えないっぽい
        [self performSegueWithIdentifier:@"toSorryView" sender:self];
    }
}

@end
