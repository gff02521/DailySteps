//
//  UtilityMacro.h
//
//  Created by Shinya Matsuyama on 12/17/10.
//  Copyright 2010 
//


#ifdef TESTFLIGHT
    #import "TestFlight.h"
    #define NSLog(__FORMAT__, ...)  TFLog((__FORMAT__   @"  %s (Line %d)"), ##__VA_ARGS__, __PRETTY_FUNCTION__, __LINE__)
    #define LOG_METHOD      TFLog(@"%s",__func__)
    #define LOGPOINT( p )   TFLog(@"pos:(%f, %f)", p.x, p.y)
    #define LOGSIZE( p )    TFLog(@"size:(%f, %f)", p.width, p.height)
    #define LOGRECT( p )    TFLog(@"rect:origin(%f, %f) size:(%f, %f)", p.origin.x, p.origin.y, p.size.wdth, p.size.height)
#elif defined DEBUG
    #define NSLog(__FORMAT__, ...)  NSLog((__FORMAT__   @"  %s (Line %d)"), ##__VA_ARGS__, __PRETTY_FUNCTION__, __LINE__)
    #define LOG_METHOD      NSLog(@"%s",__func__)
    #define LOGPOINT( p )   NSLog(@"pos:(%f, %f)", p.x, p.y)
    #define LOGSIZE( p )    NSLog(@"size:(%f, %f)", p.width, p.height)
    #define LOGRECT( p )    NSLog(@"rect:origin(%f, %f) size:(%f, %f)", p.origin.x, p.origin.y, p.size.wdth, p.size.height)
#else
    #define NSLog(...)
    #define LOG_METHOD
    #define LOGPOINT( p )
    #define LOGSIZE( p )
    #define LOGRECT( p )    
#endif

#define PI					3.141592653589793238462643383279502884197169399375105820974944592

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define PRETTY      [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]
#define IDENTIFIER  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]