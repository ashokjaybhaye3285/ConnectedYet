


#import <UIKit/UIKit.h>

#import <FacebookSDK/FacebookSDK.h>

#import "MVYMenuViewController.h"

#import "MVYSideMenuOptions.h"
#import "MVYSideMenuController.h"

#import "DropdownData.h"
#import "UsersData.h"

#import <GooglePlus/GooglePlus.h>
#import "ChatWrapper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CometChatObserver>
{
    UIView *alertView;
    UIActivityIndicatorView *indicator;
}

@property (nonatomic, retain) UINavigationController *nvc;
@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,retain)ChatWrapper *chatObj;

@property (nonatomic, retain) NSString *loginType;

@property (nonatomic, retain) UsersData *userDetails;
@property (nonatomic, retain) UsersData *tempObject;

@property (nonatomic, retain) NSMutableArray *arrayCountryDetails;

@property (nonatomic, readwrite) BOOL iPad;
@property (nonatomic, readwrite) BOOL isYourMatch;

@property (nonatomic, retain) NSString *selectedGender;
@property (nonatomic, retain) NSString *birthDate;

@property (nonatomic, retain) UIImage *profileImage;
@property (nonatomic, retain) NSData *dataVoiceNote;

@property (nonatomic, retain) DropdownData *dropDownObject;
@property (nonatomic, retain) NSMutableArray *arrayCountryData;


-(void)navigateToHomeViewController;
-(void)navigateToMatchViewController;

//-(void)navigateToGivenViewController:(UIViewController *)_controller;


- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font;
- (CGFloat)heightOfString:(NSString *)string withFont:(UIFont *)font labelWidth:(int)_width;


- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize SourceImage:(UIImage *)sourceImage;



-(void)startSpinner;
-(void)stopSpinner;

- (CGFloat)heightForString:(NSString *)string withFont:(UIFont *)font labelWidht:(int)_width;


-(NSString *)checkForNullValue:(NSString *)_parameter;

-(NSString *)getGender:(NSString *)_gender;

-(NSString *)getStringFromCity:(NSString *)_city State:(NSString *)_state Distance:(NSString *)_distance;

-(void)saveCustomObject:(UsersData *)obj;
-(UsersData *)loadCustomObjectWithKey:(NSString*)key;
-(void)clearAllData;

-(void)saveToUserDefaults:(NSString*)key value :(NSString*)value;
-(NSString*)retrieveFromUserDefaults:(NSString*)key;

@end

