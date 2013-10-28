//
//  DailyStepsCellGraphView.m
//  Act
//
//  Created by Shinya Matsuyama on 10/29/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "DailyStepsCellGraphView.h"
#import <QuartzCore/QuartzCore.h>

#define GRAPH_BAR_NUM   48
#define GRAPH_BAR_WIDTH 3.0f
#define GRAPH_BAR_SPACE 2.0f


@interface DailyStepsCellGraphView ()
@property (strong, nonatomic) NSMutableArray *graphBarsArray;
@end

@implementation DailyStepsCellGraphView

- (void)setup
{
    //  CALayerで構成していく
    _graphBarsArray = [NSMutableArray array];
    
    //  グラフのバーを全部敷いておく
    CGFloat graphPitch = GRAPH_BAR_WIDTH+GRAPH_BAR_SPACE;
    
    for(NSInteger i=0;i<GRAPH_BAR_NUM;i++)
    {
        CGRect frame = CGRectMake(i*graphPitch, CGRectGetHeight(self.bounds)-1.0, GRAPH_BAR_WIDTH, 1.0);
        
        CALayer *layer = [CALayer layer];
        layer.frame = frame;
        layer.backgroundColor = [UIApplication sharedAppDelegate].darkColor.CGColor;
        layer.opacity = 0.7;
        [self.layer addSublayer:layer];
        [_graphBarsArray addObject:layer];
    }
    
    //  背景色を透明にしておく
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

#pragma mark -

- (void)updateGraphDataArray:(NSArray*)array forKey:(NSString*)key
{
    if(GRAPH_BAR_NUM == array.count)
    {
        for(NSInteger i=0;i<array.count;i++)
        {
            NSDictionary *dic = array[i];
            NSInteger num = [dic[key] integerValue];
            
            CGFloat value = (CGFloat)num / 2500.0;
            
            CALayer *layer = _graphBarsArray[i];
            CGRect frame = layer.frame;
            
            CGFloat height = value*CGRectGetHeight(self.bounds);
            height = height<1.0?1.0:height;
            
            frame.origin.y = CGRectGetHeight(self.bounds)-height;
            frame.size.height = height;
            
            layer.frame = frame;
        }
    }
}

@end
