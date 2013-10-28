//
//  DailyStepsCell.h
//  Act
//
//  Created by Shinya Matsuyama on 10/29/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyStepsCellGraphView.h"

@interface DailyStepsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet DailyStepsCellGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

+ (CGFloat)cellHeight;

- (void)setDate:(NSDate*)date;
- (void)setSteps:(NSInteger)steps;
- (void)setGraphData:(NSArray*)array forKey:(NSString*)key;

@end
