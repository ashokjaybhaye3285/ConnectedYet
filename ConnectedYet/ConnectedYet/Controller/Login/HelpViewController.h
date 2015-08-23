//
//  HelpViewController.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 25/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface HelpViewController : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *arrayHelpData;
    
}


@end
