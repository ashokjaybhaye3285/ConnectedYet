//
//  CustomAlertView.m
//  Kntor
//
//  Created by IMAC05 on 08/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "CustomAlertView.h"
#import <QuartzCore/QuartzCore.h>

#import "Constant.h"


#define iDIOM_ALERT    UI_USER_INTERFACE_IDIOM()
#define iPAD_ALERT     UIUserInterfaceIdiomPad

#define kAlertWidth ((iDIOM_ALERT==iPAD_ALERT) ? 345.0f : 245.0f)

#define kAlertHeight ((iDIOM_ALERT==iPAD_ALERT) ? 260.0f : 260.0f)

#define kAlertContentLabelYFactor ((iDIOM_ALERT==iPAD_ALERT) ? 30.0f : 0.0f)

#define ALERT_TITLE_FONT ((iDIOM_ALERT==iPAD_ALERT) ? [UIFont fontWithName:@"Helvetica" size:22] : [UIFont fontWithName:@"Helvetica" size:20])
#define CONTENT_FONT ((iDIOM_ALERT==iPAD_ALERT) ? [UIFont fontWithName:@"Helvetica" size:18] : [UIFont fontWithName:@"Helvetica" size:15])
#define BTN_TITLE_FONT ((iDIOM_ALERT==iPAD_ALERT) ? [UIFont fontWithName:@"Helvetica" size:16] : [UIFont fontWithName:@"Helvetica" size:14])

#define descriptionSeperatorSpace 25

#define kSeparaterColor [UIColor colorWithRed:67.0/255.0 green:95.0/225.0 blue:67.0/225.0 alpha:1]

@interface CustomAlertView ()
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation CustomAlertView


+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset ((iDIOM_ALERT==iPAD_ALERT) ? 40.0f : 10.0f)



- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
         showsImage:(BOOL)_showImage
{
    if (self = [super init])
    {
        //if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
            isEnglish = YES;
        //else
        //isEnglish = NO;

        appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        
        UIView *mainBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth + 8, kAlertHeight + 8)];
        [mainBackgroundView setBackgroundColor:[UIColor whiteColor]];
        mainBackgroundView.layer.masksToBounds = YES;
            [self addSubview:mainBackgroundView];
        //mainBackgroundView.layer.cornerRadius = 5.0;
        //mainBackgroundView.backgroundColor = [UIColor whiteColor];
        //mainBackgroundView.layer.borderColor = [[UIColor colorWithRed:138.0/255.0 green:211.0/255.0 blue:153.0/255.0 alpha:1] CGColor];
        //mainBackgroundView.layer.borderWidth = 3.0;
        
        UIView *transparentBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth + 8, kAlertHeight + 8)];
        [transparentBg setBackgroundColor:[UIColor whiteColor]];
        transparentBg.alpha =  0.7f;
        transparentBg.layer.masksToBounds = YES;
        [mainBackgroundView addSubview:transparentBg];
        
        
        int yPos = 40 +  descriptionSeperatorSpace ;
        
        labelTitle = [[UILabel alloc]init];
        labelTitle.frame = CGRectMake(0, 0, mainBackgroundView.frame.size.width, 40);
        
        labelTitle.backgroundColor = [UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1];
        labelTitle.numberOfLines  = 0;
        labelTitle.font = [UIFont fontWithName:@"Helvetica" size:18];
        labelTitle.text = title;
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.textColor = [UIColor whiteColor];
        [mainBackgroundView addSubview:labelTitle];

        UILabel *labelTitleSeparator = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, mainBackgroundView.frame.size.width, 1)];
        labelTitleSeparator.backgroundColor = kSeparaterColor;
        [mainBackgroundView addSubview:labelTitleSeparator];

        
        UIImageView *imageBg = [[UIImageView alloc]init];
        imageBg.image = [UIImage imageNamed:@"rate_us_bg"];
        [mainBackgroundView addSubview:imageBg];

        
        if(_showImage)
        {
            int xPos = (mainBackgroundView.frame.size.width - 119)/2;
            
            UIButton *imageLogo = [UIButton buttonWithType:UIButtonTypeCustom];
            [imageLogo setImage:[UIImage imageNamed:@"mys_icon"] forState:UIControlStateNormal];
            imageLogo.frame = CGRectMake(xPos, yPos , 119, 60);
            [imageLogo addTarget:self action:@selector(btnImageLogo:) forControlEvents:UIControlEventTouchUpInside];
            
             //UIImageView *imageLogo = [[UIImageView alloc]init];
            //imageLogo.frame = CGRectMake(xPos, yPos , 119, 60);
            //imageLogo.image = [UIImage imageNamed:@"mys_icon"];
            //imageLogo.contentMode = UIViewContentModeScaleAspectFit;
            
            [mainBackgroundView addSubview:imageLogo];

            yPos = imageLogo.frame.origin.y + imageLogo.frame.size.height + 10;
            
        }
        
        labelDescription = [[UILabel alloc]initWithFrame:CGRectMake(10, yPos, mainBackgroundView.frame.size.width-20, 0)];
        
        UIFont *_font = [UIFont fontWithName:@"Helvetica" size:16];
        
        CGFloat descHeight = [appDelegate heightForString:content withFont:_font labelWidht:labelDescription.frame.size.width];
        
        labelDescription.frame = CGRectMake(10, yPos, mainBackgroundView.frame.size.width-20, descHeight);
        
        labelDescription.backgroundColor = [UIColor clearColor];
        labelDescription.numberOfLines  = 0;
        labelDescription.font = _font;
        labelDescription.text = content;
        labelDescription.textAlignment = NSTextAlignmentCenter;
        labelDescription.textColor = [UIColor darkGrayColor];
        [mainBackgroundView addSubview:labelDescription];
        
        yPos = labelDescription.frame.origin.y + labelDescription.frame.size.height + descriptionSeperatorSpace;

        
        UILabel *labelSeparator = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos-1, mainBackgroundView.frame.size.width, 1)];
        labelSeparator.backgroundColor = kSeparaterColor;
        [mainBackgroundView addSubview:labelSeparator];

        UILabel *labelVerticleSeparator = [[UILabel alloc]initWithFrame:CGRectMake(mainBackgroundView.frame.size.width/2, yPos, 1, kButtonHeight)];
        labelVerticleSeparator.backgroundColor = kSeparaterColor;
        [mainBackgroundView addSubview:labelVerticleSeparator];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
        mainBackgroundView.frame = CGRectMake(0, 0, kAlertWidth + 8, yPos+kButtonHeight);
        imageBg.frame = CGRectMake(0, 44, kAlertWidth + 8, yPos+kButtonHeight + 15 - 44);
        
        if (!leftTitle)
        {
            //rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5 + 4, yPos, kSingleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(0, yPos, mainBackgroundView.frame.size.width, kButtonHeight);

            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = rightBtnFrame;
            
        }
        else
        {
            //leftBtnFrame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5 +5, yPos, kCoupleButtonWidth, kButtonHeight);
            //rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + kButtonBottomOffset, yPos , kCoupleButtonWidth, kButtonHeight);
            
            leftBtnFrame = CGRectMake(0, yPos, mainBackgroundView.frame.size.width/2, kButtonHeight);
            rightBtnFrame = CGRectMake(mainBackgroundView.frame.size.width/2+1, yPos , mainBackgroundView.frame.size.width/2-1, kButtonHeight);
            
            
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if(isEnglish)
            {
                self.leftBtn.frame = leftBtnFrame;
                self.rightBtn.frame = rightBtnFrame;
            }
            else
            {
                self.leftBtn.frame = rightBtnFrame;
                self.rightBtn.frame = leftBtnFrame;
            }
        }
        
        
        self.rightBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        self.leftBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];

        
        //[self.rightBtn setBackgroundImage:[UIImage imageNamed:@"Sign-In-btn.png"] forState:UIControlStateNormal];
        //[self.leftBtn setBackgroundImage:[UIImage imageNamed:@"Sign-In-btn"] forState:UIControlStateNormal];
        
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1]];
        [self.leftBtn setBackgroundColor:[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1]];
        
        
        //self.rightBtn.layer.cornerRadius = self.rightBtn.frame.size.height/2;
        //self.leftBtn.layer.cornerRadius = self.leftBtn.frame.size.height/2;

        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = BTN_TITLE_FONT;
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        //self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
    
}


- (void)btnRateClick:(id)sender
{
    [self dismissAlert];
    if (self.rateBlock) {
        self.rateBlock();
    }
    
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}


-(void)btnImageLogo:(id)sender
{
    [self dismissAlert];
    
    if (self.btnLogo) {
        self.btnLogo();
    }
    
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    //self.frame = CGRectMake(- kAlertWidth, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds))/2 - kAlertWidth/2, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }

}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [UIView animateWithDuration:0.4f animations:^{
        
        self.alpha = 0;
        self.backImageView.alpha = 0;
        
    } completion:^(BOOL finished) {

        [self.backImageView removeFromSuperview];
        self.backImageView = nil;
        
        [super removeFromSuperview];
    }];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end

@implementation UIImage (colorful)

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



@end
