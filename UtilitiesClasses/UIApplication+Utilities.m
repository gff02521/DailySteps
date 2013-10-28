//
//  UIApplication+Utilities.m
//  Act
//
//  Created by Shinya Matsuyama on 10/28/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "UIApplication+Utilities.h"

@implementation UIApplication (Utilities)

+ (AppDelegate*)sharedAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

@end
