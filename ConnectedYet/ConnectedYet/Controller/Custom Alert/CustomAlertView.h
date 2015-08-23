//
//  CustomAlertView.h
//  Kntor
//
//  Created by IMAC05 on 08/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface CustomAlertView : UIView
{
    AppDelegate *appDelegate;
    BOOL isEnglish;
    
    UILabel *labelTitle, *labelDescription;
    
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
         showsImage:(BOOL)_showImage;



- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rateBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, copy) dispatch_block_t btnLogo;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;


@end
