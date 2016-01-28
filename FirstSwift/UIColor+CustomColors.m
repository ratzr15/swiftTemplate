//
//  UIColor+CustomColors.m
//  TSValidatedTextField-Sample
//
//  Created by Tomasz Szulc on 17.11.2013.
//  Copyright (c) 2013 Tomasz Szulc. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+(UIColor *)colorFromHex:(NSString*)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
 
// http://jira/browse/EIAO-1945: Crash in My Trips on 04/01/2015
    if (hexString.length>0)
     [scanner setScanLocation:1]; // bypass '#' character
    
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(UIColor *)colorFromHex:(NSString*)hexString WithAlpha:(float)alpha
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
// http://jira/browse/EIAO-1945:    Crash in My Trips on 04/01/2015
    if (hexString.length>0)
        [scanner setScanLocation:1]; // bypass '#' character
    
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithHexColor:(NSString*)hexString
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor colorFromHex:hexString] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
