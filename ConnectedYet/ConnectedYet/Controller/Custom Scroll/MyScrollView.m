//
//  MyScrollView.m
//  Kulshi
//
//  Created by IMAC05 on 29/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    
    // If not dragging, send event to next responder
    if (!self.dragging)
    {
        [self.nextResponder touchesEnded: touches withEvent:event];
    }
    else
        [super touchesEnded: touches withEvent: event];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // If not dragging, send event to next responder
    if (!self.dragging)
    {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    else
        [super touchesBegan: touches withEvent: event];
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // If not dragging, send event to next responder
    if (!self.dragging)
    {
        [self.nextResponder touchesMoved:touches withEvent:event];
    }
    else
        [super touchesMoved: touches withEvent: event];
    
}

@end
