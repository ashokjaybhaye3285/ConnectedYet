//
//  MyProfileView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 14/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UsersData.h"

#import "UserManager.h"
#import "AsyncImageView.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface MyProfileView : UIViewController <UserManagerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    AppDelegate *appDelegate;
    UserManager *userManager;

    UsersData *userDetailsObject;

    IBOutlet UIImageView *imageInfo, *imageWall, *imagePhotos;
    IBOutlet UIButton *btnInfo, *btnWall, *btnPhotos;

    IBOutlet AsyncImageView *imageProfile;
    
    AVAudioPlayer *player;
    IBOutlet UIButton *btnVoiceNote;

}

@property (nonatomic, readwrite) BOOL isForEdit;



@end
