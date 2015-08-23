//
//  UsersData.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 28/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersData : NSObject

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *userStatus;
@property (nonatomic, retain) NSString *userPhone;


@property (nonatomic, retain) NSString *userFirstName;
@property (nonatomic, retain) NSString *userLastName;

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userNameCanonical;

@property (nonatomic, retain) NSString *userCreatedDate;
@property (nonatomic, retain) NSString *userCredentialExpire;

@property (nonatomic, retain) NSString *userEmail;
@property (nonatomic, retain) NSString *userEmailCanonical;

@property (nonatomic, retain) NSString *userEnabled;
@property (nonatomic, retain) NSString *userExpired;

@property (nonatomic, retain) NSString *userGender;
@property (nonatomic, retain) NSString *userVerified;

@property (nonatomic, retain) NSString *userLastActivity;
@property (nonatomic, retain) NSString *userLastLogin;

@property (nonatomic, retain) NSString *userLatitude;
@property (nonatomic, retain) NSString *userLongitude;


@property (nonatomic, retain) NSString *userUpdatedDate;
@property (nonatomic, retain) NSString *userRole;


@property (nonatomic, retain) NSString *userCountryCode;
@property (nonatomic, retain) NSString *userBirthDate;

@property (nonatomic, retain) NSString *userProfileSmall;
@property (nonatomic, retain) NSString *userProfileMedium;
@property (nonatomic, retain) NSString *userProfileBig;
@property (nonatomic, retain) NSString *userProfileId;

@property (nonatomic, retain) NSString *userCity;
@property (nonatomic, retain) NSString *userState;

@property (nonatomic, retain) NSString *userAge;
@property (nonatomic, retain) NSString *userDistance;

@property (nonatomic, retain) NSString *userIsNew;

//--------

@property (nonatomic, retain) NSString *userBodyType;
@property (nonatomic, retain) NSString *userRelStatus;

@property (nonatomic, retain) NSString *userCoverSmall;
@property (nonatomic, retain) NSString *userCoverMedium;
@property (nonatomic, retain) NSString *userCoverBig;

@property (nonatomic, retain) NSString *userPreferedLang;
@property (nonatomic, retain) NSString *userPreferedLangId;

@property (nonatomic, retain) NSString *userHeight;
@property (nonatomic, retain) NSString *userHeightId;

@property (nonatomic, retain) NSString *userAudio;
@property (nonatomic, retain) NSString *userInterest;


@property (nonatomic, retain) NSMutableArray *arrayUserMovies;
@property (nonatomic, retain) NSMutableArray *arrayUserGalleryPhoto;
@property (nonatomic, retain) NSMutableArray *arrayUserLanguageSpeak;
@property (nonatomic, retain) NSMutableArray *arrayUserEthnicity;
@property (nonatomic, retain) NSMutableArray *arrayUserExersizeSport;

@property (nonatomic, retain) NSMutableArray *arrayUserEducation;
@property (nonatomic, retain) NSMutableArray *arrayUserWallData;

@property (nonatomic, retain) NSString *userEducation;
@property (nonatomic, retain) NSString *userEducationId;

@property (nonatomic, retain) NSString *userMovie;
@property (nonatomic, retain) NSString *userMovieId;

@property (nonatomic, retain) NSString *userLanguage;
@property (nonatomic, retain) NSString *userLanguageId;

@property (nonatomic, retain) NSString *userGallerySmall;
@property (nonatomic, retain) NSString *userGalleryMedium;
@property (nonatomic, retain) NSString *userGalleryBig;

@property (nonatomic, retain) NSString *userEthnicity;
@property (nonatomic, retain) NSString *userEthnicityId;

@property (nonatomic, retain) NSString *userBiography;

//--


@property (nonatomic, retain) NSString *userEyeColor;
@property (nonatomic, retain) NSString *userHairColor;
@property (nonatomic, retain) NSString *userWantMore;
@property (nonatomic, retain) NSString *userSmoke;
@property (nonatomic, retain) NSString *userIsHowMany;
@property (nonatomic, retain) NSString *userDrink;
@property (nonatomic, retain) NSString *userKids;
@property (nonatomic, retain) NSString *userExcersize;
@property (nonatomic, retain) NSString *userSign;

@property (nonatomic, retain) NSString *userSalary;
@property (nonatomic, retain) NSString *userSalaryId;

@property (nonatomic, retain) NSString *userOccupation;
@property (nonatomic, retain) NSString *userOccupationId;

@property (nonatomic, retain) NSString *userReligion;
@property (nonatomic, retain) NSString *userReligionId;


@property (nonatomic, retain) NSString *userPostLiked;
@property (nonatomic, retain) NSString *userPost;

@property (nonatomic, retain) NSString *userPostId;
@property (nonatomic, retain) NSString *userPostedDate;

@property (nonatomic, retain) NSString *userPostTotalLikes;
@property (nonatomic, retain) NSString *userPostVideoUrl;

@property (nonatomic, retain) NSString *arrayPostImages;
@property (nonatomic, retain) NSString *userPostImgSmall;
@property (nonatomic, retain) NSString *userPostImgBig;
@property (nonatomic, retain) NSString *userPostImgMedium;
@property (nonatomic, retain) NSString *userPostImgWall;

@property (nonatomic, retain) NSString *userPostedById;
@property (nonatomic, retain) NSString *userPostDescription;

@property (nonatomic, retain) NSString *userPostTotalComments;

@property (nonatomic, retain) NSString *arrayPostLikes;

@property (nonatomic, retain) NSString *userPostLikedBy;
@property (nonatomic, retain) NSString *userPostLikeDate;


@property (nonatomic, retain) NSMutableArray *arrayCommentsList;

@property (nonatomic, retain) NSString *userComment;
@property (nonatomic, retain) NSString *userCommentId;

@property (nonatomic, retain) NSString *userCommentById;
@property (nonatomic, retain) NSString *userCommentDate;

@property (nonatomic, retain) NSString *userMatch;


@property (nonatomic, retain) NSString *userInterestedIn;
@property (nonatomic, retain) NSString *userlocale;

@property (nonatomic, retain) NSString *userExSport;
@property (nonatomic, retain) NSString *userExSportId;


@end
