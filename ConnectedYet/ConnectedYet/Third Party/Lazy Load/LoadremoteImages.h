//
//  LoadremoteImages.h
//  CATLOG
//
//  Created by sk k on 20/06/11.
//  Copyright 2011 school. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"

@protocol LoadremoteImagesDelegate <NSObject>

@optional
-(void)doneWithLoadingImageForTag:(NSInteger)reqTag;

@end


@interface LoadremoteImages : UIImageView
{
    AppDelegate *appDelegate;
    
	ASIHTTPRequest *request;
	NSRange range;
	NSString *str11;
	NSString *imagefolder;
		
	UIActivityIndicatorView *activity;
    
    id <LoadremoteImagesDelegate> _delegate;
    
    BOOL isCrop;
    
}
@property(nonatomic,retain)id delegate;
@property(nonatomic,retain)UIActivityIndicatorView *activity;

// Newly added with identifier
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder identifier:(int )identifier;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cropImage:(BOOL)_crop;  //used to lazy load image with placeholder image
-(void)setfreamval:(float)x andy:(float)y andw: (float)w andh:(float)h; // shows activity indicator ongiven frame
- (void)saveImage:(NSData *)image withName:(NSString *)name; //Not used, Save downloaded image with given name.


@end
