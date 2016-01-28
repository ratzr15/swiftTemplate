//
//  UILabel+UILabelDynamicHeight.h
//  EKiPhone
//
//  Created by Dileep Varma Uppalapati on 3/26/14.
//  Copyright (c) 2014 Arun R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabelDynamicHeight)


#pragma mark - Calculate the size the Multi line Label
/*====================================================================*/

/* Calculate the size of the Multi line Label */

/*====================================================================*/
/**
 *  Returns the size of the Label
 *
 *  @param aLabel To be used to calculte the height
 *
 *  @return size of the Label
 */
-(CGSize)sizeOfMultiLineLabel;


@end
