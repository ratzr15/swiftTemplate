//
//  UIColor+CustomColors.h
//  TSValidatedTextField-Sample
//
//  Created by Tomasz Szulc on 17.11.2013.
//  Copyright (c) 2013 Tomasz Szulc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColors)


+ (UIColor *)colorFromHex:(NSString*)hexString;
+ (UIColor *)colorFromHex:(NSString*)hexString WithAlpha:(float)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithHexColor:(NSString*)hexString;

@end
