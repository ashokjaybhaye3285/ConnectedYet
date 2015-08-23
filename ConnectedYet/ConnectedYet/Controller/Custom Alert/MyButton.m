//
//  MyButton.m
//  Kntor
//
//  Created by IMAC05 on 08/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    printf("MyButton touch Began\n");
    [self.nextResponder touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    printf("MyButton touch MOVEEEEEE\n");

    //[self.nextResponder touchesMoved:touches withEvent:event];

}

@end
