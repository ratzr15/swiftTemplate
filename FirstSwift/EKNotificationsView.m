//
//  EKNotificationsView.m
//  EKiPhone
//
//  Created by Priyank on 3/23/14.
//  Copyright (c) 2014 Arun R. All rights reserved.
//

#import "EKNotificationsView.h"
#import "UIColor+CustomColors.h"
#import "UILabel+UILabelDynamicHeight.h"

@interface EKNotificationsView ()

@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIButton *detailDisclosureButton;
@property (nonatomic, strong) UIView *parentView;


@property (nonatomic, copy) void (^responseBlock)(void);
@property (nonatomic, assign) float offset;
@property (nonatomic, assign) NSTimeInterval hideInterval;
@property (nonatomic, assign) BOOL showDetailDisclosure;
@property (nonatomic) EkNotificationType notificationType;
@property (nonatomic, strong) EKNotificationsView *visibleNotificationView;
@property (nonatomic, strong) UIImageView *arrowImageView;

- (void)drawBackgroundInRect:(CGRect)rect;
- (void)showAfterDelay:(NSTimeInterval)delayInterval  withPresent:(BOOL)isPresentView;

@end

//#define PANELHEIGHT  50.0f

static NSMutableArray *notificationQueue = nil;       // Global notification queue
static BOOL isPresent;
static UINavigationController *navigation;

@implementation EKNotificationsView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame forTitle:@"" withType:0 inParentView:nil];
}

- (id)initWithFrame:(CGRect)frame forTitle:(NSString *)title withType:(EkNotificationType)type inParentView:(UIView *)parentView
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.alpha = 0.0f;
        
        _notificationType = EkNotificationTypeDefault;
        
        //Title Label
        _parentView = parentView;
        _parentView.userInteractionEnabled = NO;
        _parentView.superview.userInteractionEnabled = NO;
        
        switch (type) {
                
            case EkNotificationTypeBlue:
            case EkNotificationTypeRed:
            case EkNotificationTypeYellow:
                _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0, 12.0, [self widthForLabel]-12.0, 0.0)];
                _titleLabel.textColor = [UIColor colorFromHex:@"#554435"];//colorFromHex:@"#554435"
                break;

                
            case EkNotificationTypeGreen:
            {
                UIImage *arrowImage = [UIImage  imageNamed:@"icn_tickmark_white"];
                _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.0f, 12.0f, arrowImage.size.width, arrowImage.size.height)];
                _arrowImageView.image = arrowImage;
                [self addSubview:_arrowImageView];
                
//                _detailDisclosureButton = [[UIButton alloc] initWithFrame:CGRectMake(12.0, 12.0, _arrowImage.size.width, _arrowImage.size.height)];
//                [_detailDisclosureButton setBackgroundImage:_arrowImage forState:UIControlStateNormal];
//                [_detailDisclosureButton addTarget:self action:@selector(detailDisclosureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//                [self addSubview:_detailDisclosureButton];
                
                _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_arrowImageView.frame.size.width + 24.0, 12.0, [self widthForLabel] - 24.0 - _arrowImageView.frame.size.width, 0.0)];
                break;
            }
            default:
                break;
        }
        
        _titleLabel.text = title;
       
        CGRect labelFrame = _titleLabel.frame;
        labelFrame.size.height = [_titleLabel sizeOfMultiLineLabel].height;
        _titleLabel.frame = CGRectIntegral(labelFrame);
       
        if(type == EkNotificationTypeRed)
        {
        _titleLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        }
        
        
//        if(type == EkNotificationTypeYellow)
//        {
//            _titleLabel.textColor = [UIColor colorFromHex:@"#554435"];
// 
//        }
        _titleLabel.font = [self titleFont];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.alpha = 0.0;
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_titleLabel];
        
        //Logic error = Static Analysis: Harish
        _visibleNotificationView = self;
    }
   // _visibleNotificationView = self;

    return self;
}

- (CGFloat)heightForLabelWithTitle:(NSString *)title
{
    CGFloat height = fmaxf([title sizeWithFont:[self titleFont]
                             constrainedToSize:CGSizeMake([self widthForLabel], self.parentView.bounds.size.height)].height, 32.f);
    return height;
}


- (CGFloat)widthForLabel
{
    return self.bounds.size.width - 12.f;
}

- (UIFont *)titleFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Regular" size:13.0];
}

- (void)drawRect:(CGRect)rect
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self drawBackgroundInRect:(CGRect)rect];
}

- (void)detailDisclosureButtonPressed:(id)sender
{
    [self hide:isPresent];
}

+ (EKNotificationsView *)showNoticeInView:(UIView *)view type:(EkNotificationType)type title:(NSString *)title hideAfter:(NSTimeInterval)hideInterval  withPresent:(BOOL)isPresentView
{

    isPresent = isPresentView;
    return [self showNoticeInView:view type:type title:title  hideAfter:hideInterval offset:0.0 delay:0.0 detailDisclosure:YES withPresent:isPresentView];
}

+ (EKNotificationsView *)showNoticeInView:(UIView *)view type:(EkNotificationType)type title:(NSString *)title hideAfter:(NSTimeInterval)hideInterval  withPresent:(BOOL)isPresentView navigationController:(UINavigationController*)navController
{

    navigation=navController;
    navigation.navigationBar.userInteractionEnabled=NO;
    navigation.topViewController.navigationItem.leftBarButtonItem.enabled = NO;
    navigation.topViewController.navigationItem.rightBarButtonItem.enabled = NO;
////    navigation.topViewController.navigationController.navigationItem.leftBarButtonItem.enabled = NO;
    
    isPresent = isPresentView;
    return [self showNoticeInView:view type:type title:title  hideAfter:hideInterval offset:0.0 delay:0.0 detailDisclosure:YES withPresent:isPresentView];
    
    
}



+ (EKNotificationsView *)showNoticeInView:(UIView *)view type:(EkNotificationType)type title:(NSString *)title  hideAfter:(NSTimeInterval)hideInterval offset:(float)offset delay:(NSTimeInterval)delayInterval detailDisclosure:(BOOL)show  withPresent:(BOOL)isPresentView
{
    if ([notificationQueue count]>0)
        [notificationQueue removeAllObjects];
    
    EKNotificationsView *noticeView = [[self alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 0)
                                                         forTitle:title
                                                         withType:type
                                                     inParentView:view];
    noticeView.notificationType = type;
    noticeView.offset = offset;
    noticeView.hideInterval = hideInterval;
    noticeView.showDetailDisclosure = show;
    
    if (notificationQueue == nil)
        notificationQueue = [[NSMutableArray alloc] init];
    
    [notificationQueue addObject:noticeView];
    
    if ([notificationQueue count] == 1) {
        // Since this notification is the only one in the queue, it can be shown and its delay interval can be honored.
        [noticeView showAfterDelay:delayInterval withPresent:isPresentView];
    }
    
    return noticeView;
}

- (void)showAfterDelay:(NSTimeInterval)delayInterval  withPresent:(BOOL)isPresentView
{
    [self.parentView addSubview:self];
    [self.parentView bringSubviewToFront:self];
    
    [self setNeedsDisplay];
    
    //if parent view is a UIWindow, check if the status bar is showing (and offset the view accordin
    double statusBarOffset = ([self.parentView isKindOfClass:[UIWindow class]] && (! [[UIApplication sharedApplication] isStatusBarHidden])) ? [[UIApplication sharedApplication] statusBarFrame].size.height : 0.0;
    
    //In landscape orientation height and width are swapped, because the status bar frame is in the screen's coordinate space.
    if ((int)statusBarOffset == 1024 && ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft)){
        statusBarOffset = 0.0;
    }
    
    if ([self.parentView isKindOfClass:[UIView class]] && ![self.parentView isKindOfClass:[UIWindow class]]) {
        
        if ([UIDevice currentDevice].systemVersion.floatValue >=7) {
            if (isPresentView)
                statusBarOffset = 64.0;
            else
            {
                statusBarOffset = 0.0;
            }
        }
        else {
            if (isPresentView)
                statusBarOffset = 0.0;
            else
                statusBarOffset = 0.0;
        }
    }
//    statusBarOffset = 64.0;
    self.offset = fmax(self.offset, statusBarOffset);
    
    CGRect frame = _arrowImageView.frame;
    frame.origin.y = ((_titleLabel.frame.size.height + 22.0 - 3) - frame.size.height) / 2.0;
    _arrowImageView.frame = frame;
    
    float y_Pos = (_titleLabel.frame.size.height - _arrowImageView.frame.size.height)/2 + 11.0;
    [_arrowImageView setFrame:CGRectMake(_arrowImageView.frame.origin.x, y_Pos, _arrowImageView.frame.size.width, _arrowImageView.frame.size.height)];
    
    
    //Animation
    [UIView animateWithDuration:0.5f
                          delay:delayInterval
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 1.0;
                         self.frame = CGRectMake(0.0, self.offset - 3, self.frame.size.width, _titleLabel.frame.size.height + 22.0 - 3);
                         self.titleLabel.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
//                             if (self.showDetailDisclosure)
//                                 self.detailDisclosureButton.hidden = !self.showDetailDisclosure;
                             
                             //Hide
                             if (self.hideInterval > 0)
                                 [self performSelector:@selector(hide:) withObject:self.parentView afterDelay:self.hideInterval];
                         }
                     }];
}

#pragma mark - Hide

- (void)hide:(BOOL)isPresentView
{
    if ([self superview]) {
        _parentView.userInteractionEnabled=YES;
        _parentView.superview.userInteractionEnabled=YES;
        navigation.navigationBar.userInteractionEnabled=YES;
        navigation.topViewController.navigationItem.leftBarButtonItem.enabled = YES;
        navigation.topViewController.navigationItem.rightBarButtonItem.enabled = YES;

        [UIView animateWithDuration:0.4f
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 0.0;
                             self.frame = CGRectMake(0.0, 0.0, self.frame.size.width, 1.0);
                             self.titleLabel.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1f];
                                 [notificationQueue removeObjectIdenticalTo:self];
                             }
                         }];
    }
}

+ (void)hideCurrentNotificationView:(BOOL)isPresentView
{
    if ([notificationQueue count] > 0) {
        EKNotificationsView *currentNotification = [notificationQueue objectAtIndex:0];
        [currentNotification hide:isPresentView];
    }
}

+ (void)hideCurrentNotificationViewAndClearQueue
{
    NSUInteger numberOfNotification = [notificationQueue count];
    
    if (numberOfNotification > 1) {
        // remove all notification except the current notification
        [notificationQueue removeObjectsInRange:NSMakeRange(1, numberOfNotification -1)];
    }
    
    [EKNotificationsView hideCurrentNotificationView:isPresent];
}

+ (void)clearQueue
{
    NSUInteger numberOfNotification = [notificationQueue count];
    
    if (numberOfNotification > 1) {
        // remove all notification except the current notification
        [notificationQueue removeObjectsInRange:NSMakeRange(1, numberOfNotification -1)];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Touch events
////////////////////////////////////////////////////////////////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hide:isPresent];
    if (self.responseBlock != nil) {
        self.responseBlock();
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (void)drawBackgroundInRect:(CGRect)rect
{
    UIColor *firstColor = nil;
    UIColor *secondColor = nil;
    
    switch (self.notificationType) {
            
        case EkNotificationTypeBlue: { //Blue
            firstColor=[UIColor colorFromHex:@"#4f8feb"];
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
        }
        case EkNotificationTypeGreen: { //Green
            firstColor=[UIColor colorFromHex:@"#49a431"];
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
        }
        case EkNotificationTypeRed: { //Red
            firstColor=[UIColor colorFromHex:@"#d71921"];
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
        }
        case EkNotificationTypeYellow: { //Yellow
            firstColor=[UIColor colorFromHex:@"#f9e74e"];
            self.titleLabel.textColor = [UIColor colorFromHex:@"#554435"];
            break;
        }
            
        default: {
            
            break;
        }
    }
    
    //gradient
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGPoint startPoint1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextSaveGState(ctx);
    CGContextAddRect(ctx, rect);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, gradient, startPoint1, endPoint1, 0);
    CGContextRestoreGState(ctx);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.layer.shadowRadius = 2.0f;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
