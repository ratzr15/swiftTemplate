//
//  EKNotificationsView.h
//  EKiPhone
//
//  Created by Priyank on 3/23/14.
//  Copyright (c) 2014 Arun R. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EkNotificationTypeDefault,
    EkNotificationTypeBlue,
    EkNotificationTypeGreen,
    EkNotificationTypeRed,
    EkNotificationTypeYellow
}EkNotificationType;


@interface EKNotificationsView : UIView

/*
 *	breif	:   Method to Show The Please Wait And Success On the top Of the Screen.
 *  dated   :  3/30/14.
 *  author  :  priyank.maheshwari@emirates.com
 */

+ (EKNotificationsView *)showNoticeInView:(UIView *)view type:(EkNotificationType)type title:(NSString *)title hideAfter:(NSTimeInterval)hideInterval  withPresent:(BOOL)isPresentView;


/*
 *	breif	:   Method to Show The Please Wait And Success On the top Of the Screen.
 *  dated   :  3/30/14.
 *  author  :  priyank.maheshwari@emirates.com
 */


+ (EKNotificationsView *)showNoticeInView:(UIView *)view type:(EkNotificationType)type title:(NSString *)title hideAfter:(NSTimeInterval)hideInterval  withPresent:(BOOL)isPresentView navigationController:(UINavigationController*)navController;


/*
 *	breif	:   Method to Hide The Please Wait And Success On the top Of the Screen.
 *  dated   :  3/30/14.
 *  author  :  priyank.maheshwari@emirates.com
 */

- (void)hide:(BOOL)isPresentView;

- (UIFont *)titleFont;

/*
 *	breif	:   Method to Hide The Please Wait And Success On the top Of the Screen.
 *  dated   :  3/30/14.
 *  author  :  priyank.maheshwari@emirates.com
 */

+ (void)hideCurrentNotificationView:(BOOL)isPresentView;

+ (void)hideCurrentNotificationViewAndClearQueue;

+ (void)clearQueue;
#define hideAfterTime 4.0


@end
