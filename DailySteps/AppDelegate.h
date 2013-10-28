//
//  AppDelegate.h
//  Act
//
//  Created by Shinya Matsuyama on 10/27/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//  アプリで共通して使う色
@property (readonly, nonatomic) UIColor *darkColor;
@property (readonly, nonatomic) UIColor *lightColor;
@property (readonly, nonatomic) UIColor *lightDownColor;
@property (readonly, nonatomic) UIColor *textColor;

//  アプリで共通して使うフォント
@property (readonly, nonatomic) UIFont *naviTitleFont;

@end
