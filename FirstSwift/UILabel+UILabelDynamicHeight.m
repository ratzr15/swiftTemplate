//
//  UILabel+UILabelDynamicHeight.m
//  EKiPhone
//
//  Created by Dileep Varma Uppalapati on 3/26/14.
//  Copyright (c) 2014 Arun R. All rights reserved.
//

#import "UILabel+UILabelDynamicHeight.h"


@implementation UILabel (UILabelDynamicHeight)


#pragma mark - Calculate the size,bounds,frame of the Multi line Label
/*====================================================================*/

/* Calculate the size,bounds,frame of the Multi line Label */

/*====================================================================*/
/**
 *  Returns the size of the Label
 *
 *  @param aLabel To be used to calculte the height
 *
 *  @return size of the Label
 */
-(CGSize)sizeOfMultiLineLabel{
    
    NSAssert(self, @"UILabel was nil");
    
    //Label text
    NSString *aLabelTextString = [self text];
    
    //Label font
    UIFont *aLabelFont = [self font];
    
    //Width of the Label
    CGFloat aLabelSizeWidth = self.frame.size.width;
    
    
    CGSize sizeVariable;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        //version < 7.0
        
        sizeVariable = [aLabelTextString sizeWithFont:aLabelFont
                            constrainedToSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rectVar = CGRectIntegral(CGRectMake(0.0f, 0.0f, sizeVariable.width, sizeVariable.height));
        sizeVariable = CGSizeMake(rectVar.size.width, rectVar.size.height);
        return sizeVariable;
    }
    else if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        //version >= 7.0
        
        //Return the calculated size of the Label
        sizeVariable = [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSFontAttributeName : aLabelFont
                                                        }
                                              context:nil].size;
        CGRect rectVar = CGRectIntegral(CGRectMake(0.0f, 0.0f, sizeVariable.width, sizeVariable.height));
        sizeVariable = CGSizeMake(rectVar.size.width, rectVar.size.height);
        return sizeVariable;
    }
    
    sizeVariable = [self bounds].size;
    CGRect rectVar = CGRectIntegral(CGRectMake(0.0f, 0.0f, sizeVariable.width, sizeVariable.height));
    sizeVariable = CGSizeMake(rectVar.size.width, rectVar.size.height);
    return sizeVariable;
}


@end
