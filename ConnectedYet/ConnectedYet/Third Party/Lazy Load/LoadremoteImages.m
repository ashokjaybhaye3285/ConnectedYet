//
//  LoadremoteImages.m
//  CATLOG
//
//  Created by sk k on 20/06/11.
//  Copyright 2011 school. All rights reserved.
//

#import "LoadremoteImages.h"
//#import "UIImage+FX.h"

@implementation LoadremoteImages
@synthesize activity;
@synthesize delegate;


- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder identifier:(int )identifier
{
    [request setDelegate:nil];
    //[request cancel];
    //[request release];
    
    [self setBackgroundColor:[UIColor clearColor]];
    request = [[ASIHTTPRequest requestWithURL:url] retain];
    
    request.tag=identifier;
    
    //[request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    
    self.contentMode = UIViewContentModeCenter;
    
    if (placeholder)
        self.image =placeholder;// [UIImage imageNamed:@"noimage.png"];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cropImage:(BOOL)_crop
{
	[request setDelegate:nil];
    //[request cancel];
    //[request release];
    
    isCrop = _crop;
    
	[self setBackgroundColor:[UIColor clearColor]];
    request = [[ASIHTTPRequest requestWithURL:url] retain];
    
    request.tag=216;
    
    //[request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    
    self.contentMode = UIViewContentModeCenter;
	
    if (placeholder)
		self.image =placeholder;// [UIImage imageNamed:@"noimage.png"];
	
	[request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)setfreamval:(float)x andy:(float)y andw: (float)w andh:(float)h
{
   self.frame = CGRectMake(x, y, w, h);
	
	activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((w-30)/2, (h-30)/2, 30, 30)];
	
	if (activity!=nil)
	{
		[activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		[self addSubview:activity];
		[activity startAnimating];
	}
	// [activity setCenter:CGPointMake(w,h)];
}

- (void)dealloc
{
    [activity release];
    [request setDelegate:nil];
    [request cancel];
    [request release];
    [super dealloc];
}


- (void)requestFinished:(ASIHTTPRequest *)req
{
    if (request.responseStatusCode != 200)
	{
        [activity stopAnimating];
        return;
	}

    if(request.responseData!=nil)
    {
        self.image = [UIImage imageWithData:request.responseData];
        
        //TODO: Crop Image As per Size
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        if(isCrop)
        {
            CGSize mySize = CGSizeMake(self.frame.size.width, self.frame.size.height);
            self.image = [appDelegate imageByScalingAndCroppingForSize:mySize SourceImage:self.image];
            self.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        [activity stopAnimating];
        
    }
  
	if (activity!=nil)
	{
		[activity stopAnimating];
		[activity removeFromSuperview];
	}

    if (self.delegate) {
        [self.delegate doneWithLoadingImageForTag:request.tag];
    }
}

- (void)saveImage:(NSData *)image withName:(NSString *)name
{
	/*
     NSLog(@"name == %@",name);
     //save image
     NSFileManager *fileManager = [NSFileManager defaultManager];
     
     
     if ([appDelegate.documentsDirectory length]==0)
     {
     NSArray *paths=[[NSArray alloc] init];
     
     paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     
     appDelegate.documentsDirectory=[NSString stringWithFormat:@"%@/Images",[paths objectAtIndex:0]];
     
     }
     
     NSString *fullPath = [NSString stringWithFormat:@"%@/%@",appDelegate.documentsDirectory,name];
     
     BOOL success=[fileManager createFileAtPath:fullPath contents:image attributes:nil];
     
     if (success)
     {
     NSLog(@"  path created");
     }
     */
}

@end
