//
//  DailyStepsCell.m
//  Act
//
//  Created by Shinya Matsuyama on 10/29/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "DailyStepsCell.h"

@implementation DailyStepsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -

+ (CGFloat)cellHeight
{
    return 72.0;
}

#pragma mark -

- (NSString*)monthStringFromNum:(NSInteger)month
{
    NSString *rep = nil;
    switch(month)
    {
        case 1:
            rep = @"Jan";
            break;
            
        case 2:
            rep = @"Feb";
            break;
            
        case 3:
            rep = @"Mar";
            break;
            
        case 4:
            rep = @"Apr";
            break;
            
        case 5:
            rep = @"May";
            break;
            
        case 6:
            rep = @"Jun";
            break;
            
        case 7:
            rep = @"Jul";
            break;
            
        case 8:
            rep = @"Aug";
            break;
            
        case 9:
            rep = @"Sep";
            break;
            
        case 10:
            rep = @"Oct";
            break;
            
        case 11:
            rep = @"Nov";
            break;
            
        case 12:
            rep = @"Dec";
            break;
    }
    return rep;
}

- (NSString*)weekdayStringFromNum:(NSInteger)weekday
{
    NSString *rep = nil;
    switch(weekday)
    {
        case 1:
            rep = @"SUN";
            break;
            
        case 2:
            rep = @"MON";
            break;
            
        case 3:
            rep = @"TUE";
            break;
            
        case 4:
            rep = @"WED";
            break;
            
        case 5:
            rep = @"THU";
            break;
            
        case 6:
            rep = @"FRI";
            break;
            
        case 7:
            rep = @"SAT";
            break;
    }
    return rep;
}

- (void)setDate:(NSDate*)date
{
    NSDateComponents *comps;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    comps = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:date];
    
    NSInteger month = comps.month;
    NSInteger day = comps.day;
    NSInteger weekday = comps.weekday;
    
    _weekdayLabel.text = [self weekdayStringFromNum:weekday];
    _dateLabel.text = [NSString stringWithFormat:@"%@, %d", [self monthStringFromNum:month], (int)day];
}

- (void)setSteps:(NSInteger)steps
{
    _stepsLabel.text = [NSString stringWithFormat:@"%d", (int)steps];
}

- (void)setGraphData:(NSArray*)array forKey:(NSString*)key
{
    [_graphView updateGraphDataArray:array forKey:key];
}

@end
