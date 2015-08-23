//
//  UsersData.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 28/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "UsersData.h"

@implementation UsersData

@synthesize userId;
@synthesize userStatus;
@synthesize userPhone;

@synthesize userFirstName;
@synthesize userLastName;

@synthesize userName;
@synthesize userNameCanonical;

@synthesize userCreatedDate;
@synthesize userCredentialExpire;

@synthesize userEmail;
@synthesize userEmailCanonical;

@synthesize userEnabled;
@synthesize userExpired;

@synthesize userGender;
@synthesize userVerified;

@synthesize userLastActivity;
@synthesize userLastLogin;

@synthesize userLatitude;
@synthesize userLongitude;

@synthesize userUpdatedDate;
@synthesize userRole;

@synthesize userCountryCode;
@synthesize userBirthDate;

@synthesize userProfileSmall;
@synthesize userProfileMedium;
@synthesize userProfileBig;
@synthesize userProfileId;

@synthesize userCity;
@synthesize userState;
@synthesize userAge;
@synthesize userDistance;
@synthesize userIsNew;



@synthesize userBodyType;
@synthesize userRelStatus;

@synthesize userCoverSmall;
@synthesize userCoverMedium;
@synthesize userCoverBig;

@synthesize userPreferedLang;
@synthesize userPreferedLangId;

@synthesize userHeight;
@synthesize userHeightId;

@synthesize userAudio;
@synthesize userInterest;


@synthesize arrayUserMovies;
@synthesize arrayUserGalleryPhoto;
@synthesize arrayUserLanguageSpeak;
@synthesize arrayUserEthnicity;
@synthesize arrayUserExersizeSport;

@synthesize arrayUserEducation;
@synthesize arrayUserWallData;

@synthesize userEducation;
@synthesize userEducationId;

@synthesize userMovie;
@synthesize userMovieId;

@synthesize userLanguage;
@synthesize userLanguageId;

@synthesize userGallerySmall;
@synthesize userGalleryMedium;
@synthesize userGalleryBig;

@synthesize userEthnicity;
@synthesize userEthnicityId;


@synthesize userBiography;


@synthesize userEyeColor;
@synthesize userHairColor;
@synthesize userWantMore;
@synthesize userSmoke;
@synthesize userIsHowMany;
@synthesize userDrink;
@synthesize userKids;
@synthesize userExcersize;
@synthesize userSign;
@synthesize userSalary;
@synthesize userSalaryId;
@synthesize userOccupation;
@synthesize userOccupationId;
@synthesize userReligion;
@synthesize userReligionId;


@synthesize userPostLiked;
@synthesize userPost;
@synthesize userPostId;
@synthesize userPostedDate;
@synthesize userPostTotalLikes;
@synthesize arrayPostImages;
@synthesize userPostImgSmall;

@synthesize userPostImgBig;
@synthesize userPostImgMedium;
@synthesize userPostImgWall;
@synthesize userPostedById;
@synthesize userPostDescription;
@synthesize userPostTotalComments;
@synthesize arrayPostLikes;
@synthesize userPostLikedBy;
@synthesize userPostLikeDate;

@synthesize arrayCommentsList;

@synthesize userComment;
@synthesize userCommentId;

@synthesize userCommentById;
@synthesize userCommentDate;


@synthesize userMatch;

@synthesize userInterestedIn;
@synthesize userlocale;

@synthesize userExSport;
@synthesize userExSportId;


- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        //decode properties, other class vars
        userId = [decoder decodeObjectForKey:@"id"];
        userName = [decoder decodeObjectForKey:@"username"];

        userFirstName = [decoder decodeObjectForKey:@"fisrtname"];
        userLastName = [decoder decodeObjectForKey:@"lastname"];
        
        userEmail = [decoder decodeObjectForKey:@"email"];
        userCountryCode = [decoder decodeObjectForKey:@"country"];
        
        userBirthDate = [decoder decodeObjectForKey:@"date_of_birth"];
        userAge = [decoder decodeObjectForKey:@"age"];

        userAudio = [decoder decodeObjectForKey:@"audio"];
        userGender = [decoder decodeObjectForKey:@"gender"];

        userCity = [decoder decodeObjectForKey:@"city"];
        userState = [decoder decodeObjectForKey:@"state"];

        userLatitude = [decoder decodeObjectForKey:@"latitude"];
        userLongitude = [decoder decodeObjectForKey:@"longitude"];

        userProfileSmall = [decoder decodeObjectForKey:@"profilePicSmall"];
        userProfileMedium = [decoder decodeObjectForKey:@"profilePic"];
        userProfileBig = [decoder decodeObjectForKey:@"profilePicBig"];
        
        userPhone = [decoder decodeObjectForKey:@"phone"];
        userInterest = [decoder decodeObjectForKey:@"userInterest"];

        
        userBiography = [decoder decodeObjectForKey:@"userBiography"];
        userBodyType = [decoder decodeObjectForKey:@"userBodyType"];

        userDrink = [decoder decodeObjectForKey:@"userDrink"];
        userEyeColor = [decoder decodeObjectForKey:@"userEyeColor"];

        userExcersize = [decoder decodeObjectForKey:@"userExcersize"];
        userHairColor = [decoder decodeObjectForKey:@"userHairColor"];

        userInterestedIn = [decoder decodeObjectForKey:@"userInterestedIn"];
        userIsHowMany = [decoder decodeObjectForKey:@"userIsHowMany"];

        userKids = [decoder decodeObjectForKey:@"userKids"];
        userPreferedLang = [decoder decodeObjectForKey:@"userPreferedLang"];

        userRelStatus = [decoder decodeObjectForKey:@"userRelStatus"];
        userSign = [decoder decodeObjectForKey:@"userSign"];

        userlocale = [decoder decodeObjectForKey:@"userlocale"];
        userSmoke = [decoder decodeObjectForKey:@"userSmoke"];

        userWantMore = [decoder decodeObjectForKey:@"userWantMore"];

        userEducation = [decoder decodeObjectForKey:@"userEducation"];
        userEducationId = [decoder decodeObjectForKey:@"userEducationId"];
        
        userEthnicity = [decoder decodeObjectForKey:@"userEthnicity"];
        userEthnicityId = [decoder decodeObjectForKey:@"userEthnicityId"];

        userExSport = [decoder decodeObjectForKey:@"userExSport"];
        userExSportId = [decoder decodeObjectForKey:@"userExSportId"];

        userHeight = [decoder decodeObjectForKey:@"userHeight"];
        userHeightId = [decoder decodeObjectForKey:@"userHeightId"];

        userLanguage = [decoder decodeObjectForKey:@"userLanguage"];
        userLanguageId = [decoder decodeObjectForKey:@"userLanguageId"];

        userMovie = [decoder decodeObjectForKey:@"userMovie"];
        userMovieId = [decoder decodeObjectForKey:@"userMovieId"];
        
        userOccupation = [decoder decodeObjectForKey:@"userOccupation"];
        userOccupationId = [decoder decodeObjectForKey:@"userOccupationId"];
        
        userReligion = [decoder decodeObjectForKey:@"userReligion"];
        userReligionId = [decoder decodeObjectForKey:@"userReligionId"];
        
        userSalary = [decoder decodeObjectForKey:@"userSalary"];
        userSalaryId = [decoder decodeObjectForKey:@"userSalaryId"];
        

    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:userId forKey:@"id"];
    [encoder encodeObject:userName forKey:@"username"];

    [encoder encodeObject:userFirstName forKey:@"fisrtname"];
    [encoder encodeObject:userLastName forKey:@"lastname"];
    
    [encoder encodeObject:userEmail forKey:@"email"];
    [encoder encodeObject:userCountryCode forKey:@"country"];
    
    [encoder encodeObject:userBirthDate forKey:@"date_of_birth"];
    [encoder encodeObject:userAge forKey:@"age"];

    [encoder encodeObject:userAudio forKey:@"audio"];
    [encoder encodeObject:userGender forKey:@"gender"];

    [encoder encodeObject:userCity forKey:@"city"];
    [encoder encodeObject:userState forKey:@"state"];

    [encoder encodeObject:userLatitude forKey:@"latitude"];
    [encoder encodeObject:userLongitude forKey:@"longitude"];

    [encoder encodeObject:userProfileSmall forKey:@"profilePicSmall"];
    [encoder encodeObject:userProfileMedium forKey:@"profilePic"];
    [encoder encodeObject:userProfileBig forKey:@"profilePicBig"];

    [encoder encodeObject:userPhone forKey:@"phone"];
    [encoder encodeObject:userInterest forKey:@"userInterest"];

    [encoder encodeObject:userBiography forKey:@"userBiography"];
    [encoder encodeObject:userBodyType forKey:@"userBodyType"];

    [encoder encodeObject:userDrink forKey:@"userDrink"];
    [encoder encodeObject:userExcersize forKey:@"userExcersize"];

    [encoder encodeObject:userEyeColor forKey:@"userEyeColor"];
    [encoder encodeObject:userHairColor forKey:@"userHairColor"];

    [encoder encodeObject:userInterestedIn forKey:@"userInterestedIn"];
    [encoder encodeObject:userIsHowMany forKey:@"userIsHowMany"];

    [encoder encodeObject:userKids forKey:@"userKids"];
    [encoder encodeObject:userPreferedLang forKey:@"userPreferedLang"];

    [encoder encodeObject:userRelStatus forKey:@"userRelStatus"];
    [encoder encodeObject:userSign forKey:@"userSign"];

    [encoder encodeObject:userlocale forKey:@"userlocale"];
    [encoder encodeObject:userSmoke forKey:@"userSmoke"];

    [encoder encodeObject:userWantMore forKey:@"userWantMore"];
   
    [encoder encodeObject:userEducation forKey:@"userEducation"];
    [encoder encodeObject:userEducationId forKey:@"userEducationId"];

    [encoder encodeObject:userEthnicity forKey:@"userEthnicity"];
    [encoder encodeObject:userEthnicityId forKey:@"userEthnicityId"];

    [encoder encodeObject:userExSport forKey:@"userExSport"];
    [encoder encodeObject:userExSportId forKey:@"userExSportId"];

    [encoder encodeObject:userHeight forKey:@"userHeight"];
    [encoder encodeObject:userHeightId forKey:@"userHeightId"];
    
    [encoder encodeObject:userLanguage forKey:@"userLanguage"];
    [encoder encodeObject:userLanguageId forKey:@"userLanguageId"];

    [encoder encodeObject:userMovie forKey:@"userMovie"];
    [encoder encodeObject:userMovieId forKey:@"userMovieId"];

    [encoder encodeObject:userOccupation forKey:@"userOccupation"];
    [encoder encodeObject:userOccupationId forKey:@"userOccupationId"];

    [encoder encodeObject:userReligion forKey:@"userReligion"];
    [encoder encodeObject:userReligionId forKey:@"userReligionId"];

    [encoder encodeObject:userSalary forKey:@"userSalary"];
    [encoder encodeObject:userSalaryId forKey:@"userSalaryId"];

}


@end
