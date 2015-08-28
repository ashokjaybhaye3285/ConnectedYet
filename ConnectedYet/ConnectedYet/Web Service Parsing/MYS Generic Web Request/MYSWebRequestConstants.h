//
//  MYSWebRequestConstants.h
//  MYSWebRequestComponent
//
//  Created by IMAC05 on 26/06/14.
//  Copyright (c) 2014 IMAC05. All rights reserved.
//

#ifndef MYSWebRequestComponent_MYSWebRequestConstants_h
#define MYSWebRequestComponent_MYSWebRequestConstants_h

#define STATUS_SUCCESS @"Success"
#define STATUS_FAILED @"Failed"


#define MYS_RESPONSE_DATA_KEY @"ResponseData"
#define MYS_RESPONSE_STATUS_KEY @"RequestStatus"


#define MYS_REQUEST_BASE_URL @"http://aegis-infotech.com/connectedyet/web/api/"   //LIVE
//#define MYS_REQUEST_BASE_URL @"http://aegis-infotech.com/connectedyet/web/app_dev.php/api/"   //Developement


#define MYS_VIDEO_UPLOAD_REQUEST_BASE_URL @""

#define MYS_REQUEST_TIMEOUT 30
#define MYS_REQUEST_ID_KEY @"RequestIdentifier"
#define MYS_CONTENT_TYPE_KEY @"Content-Type"
#define MYS_CONTENT_TYPE_VALUE @"application/x-www-form-urlencoded"

#define MYS_REQUEST_SUCCESSFULL 0
#define MYS_REQUEST_FAILED -1
#define MYS_REQUEST_TIMEDOUT -2
#define MYS_NETWORK_FAILURE -3
#define MYS_INCORRECT_REQUEST -4

#endif
