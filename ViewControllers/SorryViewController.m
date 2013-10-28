//
//  SorryViewController.m
//  Act
//
//  Created by Shinya Matsuyama on 10/28/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "SorryViewController.h"

@interface SorryViewController ()

@end

@implementation SorryViewController

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

@end
