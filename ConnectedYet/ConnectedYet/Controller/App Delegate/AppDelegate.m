


#import "AppDelegate.h"
#import "LoginViewController.h"

#import "HomeViewController.h"
#import "HelpViewController.h"
#import "UsersCommonView.h"
#import "Constant.h"

#import <GooglePlus/GooglePlus.h>

#import <Instabug/Instabug.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize iPad;

@synthesize userDetails;
@synthesize tempObject;

@synthesize loginType;

@synthesize nvc;
@synthesize isYourMatch;

@synthesize arrayCountryDetails;

@synthesize selectedGender;
@synthesize birthDate;

@synthesize profileImage;
@synthesize dataVoiceNote;

@synthesize dropDownObject;
@synthesize arrayCountryData;

/*
#pragma mark Facebook
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                sourceApplication:sourceApplication
                                  fallbackHandler:^(FBAppCall *call) {
                                      NSLog(@"Unhandled deep link: %@", url);
                                  }];
    
    return urlWasHandled;
}
*/

- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation
{
    NSLog(@"--- APP DELEGATE open URL ------------------");
    
    if([loginType isEqualToString:kGooglePlus])
    {
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }
    else if([loginType isEqualToString:kFB])
    {
        BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                    sourceApplication:sourceApplication
                                      fallbackHandler:^(FBAppCall *call) {
                                          NSLog(@"Unhandled deep link: %@", url);
                                      }];
        
        return urlWasHandled;

    }
    else
    {
        
    }

    return nil;
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
#if DEBUG
    NSLog(@"-- Device Width : %f",[[UIScreen mainScreen] bounds].size.width);
    NSLog(@"-- Device Height : %f",[[UIScreen mainScreen] bounds].size.height);
#endif
    
    //Instabug
    [Instabug startWithToken:@"721f1f075508e065aaf25967de43dea4" captureSource:IBGCaptureSourceUIKit invocationEvent:IBGInvocationEventShake];

    tempObject = [[UsersData alloc]init];
    
    userDetails = [self loadCustomObjectWithKey:@"myLoginData"]; // USER OBJECT
    
    [self saveToUserDefaults:kChatLogin value:@"NO"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        iPad = YES;
    else
        iPad = NO;


    if([userDetails.userId intValue])
        [self navigateToHomeViewController];
    else
    {
        HelpViewController *help;
        
        if(iPad)
            help = [[HelpViewController alloc]initWithNibName:@"HelpViewController_iPad" bundle:nil];
        else
            help = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
        
        nvc = [[UINavigationController alloc]initWithRootViewController:help];
        
        [self.window setRootViewController:nvc];
        nvc.navigationBarHidden = YES;

    }
    
       //self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    return YES;
    
}


-(void)navigateToHomeViewController
{
    MVYMenuViewController *menuVC = [[MVYMenuViewController alloc] initWithNibName:@"MVYMenuViewController" bundle:nil];
    
    HomeViewController *homeView;
    
    if(iPad)
        homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
    else
        homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];

    homeView.isYourMatch = isYourMatch;
    isYourMatch = NO;
    
    nvc = [[UINavigationController alloc] initWithRootViewController:homeView];
    nvc.navigationBarHidden = YES;
    
    MVYSideMenuOptions *options = [[MVYSideMenuOptions alloc] init];
    options.contentViewScale = 1.0;
    options.contentViewOpacity = 0.05;
    options.shadowOpacity = 0.0;
    
    MVYSideMenuController *sideMenuController = [[MVYSideMenuController alloc] initWithMenuViewController:menuVC
             contentViewController:nvc
                           options:options];
    
    if(iPad)
        sideMenuController.menuFrame = CGRectMake(0, 70.0, 200.0, self.window.bounds.size.height - 70.0);
    else
        sideMenuController.menuFrame = CGRectMake(0, 64.0, 190.0, self.window.bounds.size.height - 64.0);

    
    self.window.rootViewController = sideMenuController;
}

-(void)navigateToMatchViewController
{
    MVYMenuViewController *menuVC = [[MVYMenuViewController alloc] initWithNibName:@"MVYMenuViewController" bundle:nil];
    
    UsersCommonView *match;
    
    if(iPad)
        match = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
    else
        match = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
    
    match.strHeaderTitle = @"My Match";
    
    
    nvc = [[UINavigationController alloc] initWithRootViewController:match];
    nvc.navigationBarHidden = YES;
    
    MVYSideMenuOptions *options = [[MVYSideMenuOptions alloc] init];
    options.contentViewScale = 1.0;
    options.contentViewOpacity = 0.05;
    options.shadowOpacity = 0.0;
    
    MVYSideMenuController *sideMenuController = [[MVYSideMenuController alloc] initWithMenuViewController:menuVC
                                                                                    contentViewController:nvc
                                                                                                  options:options];
    
    if(iPad)
        sideMenuController.menuFrame = CGRectMake(0, 70.0, 200.0, self.window.bounds.size.height - 70.0);
    else
        sideMenuController.menuFrame = CGRectMake(0, 64.0, 190.0, self.window.bounds.size.height - 64.0);
    
    self.window.rootViewController = sideMenuController;

}


/*
-(void)navigateToGivenViewController:(UIViewController *)_controller
{
    MVYMenuViewController *menuVC = [[MVYMenuViewController alloc] initWithNibName:@"MVYMenuViewController" bundle:nil];
    
    
    nvc = [[UINavigationController alloc] initWithRootViewController:_controller];
    nvc.navigationBarHidden = YES;
    
    MVYSideMenuOptions *options = [[MVYSideMenuOptions alloc] init];
    options.contentViewScale = 1.0;
    options.contentViewOpacity = 0.05;
    options.shadowOpacity = 0.0;
    
    MVYSideMenuController *sideMenuController = [[MVYSideMenuController alloc] initWithMenuViewController:menuVC
                                                                                    contentViewController:nvc
                                                                                                  options:options];
    
    if(iPad)
        sideMenuController.menuFrame = CGRectMake(0, 70.0, 200.0, self.window.bounds.size.height - 70.0);
    else
        sideMenuController.menuFrame = CGRectMake(0, 64.0, 190.0, self.window.bounds.size.height - 64.0);
    
    
    self.window.rootViewController = sideMenuController;
    
}
*/
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark ----- DYNAMIC WIDTH ----

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

#pragma mark ----- DYNAMIC HEIGHT ----

- (CGFloat)heightOfString:(NSString *)string withFont:(UIFont *)font labelWidth:(int)_width
{
    CGSize maximumLabelSize = CGSizeMake(_width,9999);
    CGSize expectedLabelSize = [string sizeWithFont:font
                                  constrainedToSize:maximumLabelSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"-- Height : %f",expectedLabelSize.height);
    
    return expectedLabelSize.height;
    
}



- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize SourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


#pragma mark --- --- ---- ------
#pragma mark --- ---  SPINNER METHOD  ---- ------

-(void)startSpinner
{
#if DEBUG
    NSLog(@"***** App Delegate Start Spinner *****");
#endif
    
    if([alertView superview])
        [alertView removeFromSuperview];
    
    alertView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width,  self.window.frame.size.height)];
    alertView.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width,  self.window.frame.size.height)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [alertView addSubview:bgView];
    
    if(indicator==nil)
        indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [indicator startAnimating];
    indicator.hidesWhenStopped=YES;
    [indicator setCenter:CGPointMake(self.window.frame.size.width/2,self.window.frame.size.height/2)];
    [alertView addSubview:indicator];
    
    [self.window addSubview:alertView];
    
}

-(void)stopSpinner
{
#if DEBUG
    NSLog(@"***** App Delegate Stop Spinner *****");
#endif
    
    if(alertView!=nil)
    {
        [alertView removeFromSuperview];
        alertView = nil;
        
    }
    
}

#pragma mark --- --- ---- ------
#pragma mark --- --- HEIGHT FOR STRING ---- ------

- (CGFloat)heightForString:(NSString *)string withFont:(UIFont *)font labelWidht:(int)_width
{
    CGSize maximumLabelSize = CGSizeMake(_width,9999);
    CGSize expectedLabelSize = [string sizeWithFont:font
                                  constrainedToSize:maximumLabelSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    
    //NSLog(@"-- Height : %f",expectedLabelSize.height);
    
    return expectedLabelSize.height;
    
}

#pragma mark --- --- ---- ------
#pragma mark ----  -----  CHECK NULL VALUE  -----  -----


-(NSString *)checkForNullValue:(NSString *)_parameter
{
    NSString *strParameter;
    
    if (_parameter == nil || [_parameter isKindOfClass:[NSNull class]])
        strParameter = @"";
    else
        strParameter = _parameter;
    
    return strParameter;
    
}

-(NSString *)getGender:(NSString *)_gender
{
    NSString *gender;
    
    if([_gender isEqualToString:@"M"] || [_gender isEqualToString:@"m"])
        gender = @"Male";
    else if([_gender isEqualToString:@"F"] || [_gender isEqualToString:@"f"])
        gender = @"Female";
    else
        gender = @"Unknown";
    
    return  gender;
    
}

-(NSString *)getStringFromCity:(NSString *)_city State:(NSString *)_state Distance:(NSString *)_distance
{
    NSString *finalString = @"";
    
    if(_city.length !=0)
    {
        finalString = [finalString stringByAppendingString:_city];
        
        if(_state.length !=0)
        {
            finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@", %@",_state]];

            if(_distance.length !=0)
                finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@", %@",_distance]];

        }
        else
        {
            if(_distance.length !=0)
                finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@"%@",_distance]];

        }
        
    }
    else
    {
        if(_state.length !=0)
        {
            finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@"%@",_state]];
            
            if(_distance.length !=0)
                finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@", %@",_distance]];
            
        }
        else
        {
            if(_distance.length !=0)
                finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@"%@",_distance]];
            
        }

    }
    
    return finalString;
    
}


#pragma mark --- --- ---- ------

-(void)saveCustomObject:(UsersData *)obj
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    
    [defaults setObject:myEncodedObject forKey:@"myLoginData"];
    
    userDetails = [self loadCustomObjectWithKey:@"myLoginData"];
    
    NSLog(@"-- SAVE OBJECT : %@", userDetails.userId);

}

-(UsersData *)loadCustomObjectWithKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey: key];
    
    UsersData* obj = (UsersData *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    
    NSLog(@"-- LOAD OBJECT : %@", obj);

    return obj;
    
}

-(void)clearAllData
{
    NSLog(@"-- Clear Data ---");
    
    [self saveCustomObject:Nil];
    [self saveToUserDefaults:kChatLogin value:@"NO"];

    userDetails = nil;
}

-(void)saveToUserDefaults:(NSString*)key value :(NSString*)value
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}
-(NSString*)retrieveFromUserDefaults:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *val = nil;
    
    if (standardUserDefaults)
        val = [standardUserDefaults objectForKey:key];
    
    return val;
}

@end
