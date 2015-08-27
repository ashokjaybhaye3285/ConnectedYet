/*
 
 CometChat
 Copyright (c) 2015 Inscripts
 
 CometChat ('the Software') is a copyrighted work of authorship. Inscripts
 retains ownership of the Software and any copies of it, regardless of the
 form in which the copies may exist. This license is not a sale of the
 original Software or any copies.
 
 By installing and using CometChat on your server, you agree to the following
 terms and conditions. Such agreement is either on your own behalf or on behalf
 of any corporate entity which employs you or which you represent
 ('Corporate Licensee'). In this Agreement, 'you' includes both the reader
 and any Corporate Licensee and 'Inscripts' means Inscripts (I) Private Limited:
 
 CometChat license grants you the right to run one instance (a single installation)
 of the Software on one web server and one web site for each license purchased.
 Each license may power one instance of the Software on one domain. For each
 installed instance of the Software, a separate license is required.
 The Software is licensed only to you. You may not rent, lease, sublicense, sell,
 assign, pledge, transfer or otherwise dispose of the Software in any form, on
 a temporary or permanent basis, without the prior written consent of Inscripts.
 
 The license is effective until terminated. You may terminate it
 at any time by uninstalling the Software and destroying any copies in any form.
 
 The Software source code may be altered (at your risk)
 
 All Software copyright notices within the scripts must remain unchanged (and visible).
 
 The Software may not be used for anything that would represent or is associated
 with an Intellectual Property violation, including, but not limited to,
 engaging in any activity that infringes or misappropriates the intellectual property
 rights of others, including copyrights, trademarks, service marks, trade secrets,
 software piracy, and patents held by individuals, corporations, or other entities.
 
 If any of the terms of this Agreement are violated, Inscripts reserves the right
 to revoke the Software license at any time.
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <Foundation/Foundation.h>

/* Enum for Changing user status */
typedef NS_ENUM (NSInteger, STATUS_OPTIONS) {
    
    STATUS_AVAILABLE,
    STATUS_BUSY,
    STATUS_INVISIBLE,
    STATUS_OFFLINE
};

typedef NS_ENUM(NSInteger, LANGUAGE) {
    Default,
    Afrikaans,
    Albanian,
    Arabic,
    Belarusian,
    Bulgarian,
    Catalan,
    Chinese_Simpl,
    Chinese_Trad,
    Croatian,
    Czech,
    Danish,
    Dutch,
    English,
    Estonian,
    Filipino,
    Finnish,
    French,
    Galician,
    German,
    Greek,
    Haitian_Creole,
    Hebrew,
    Hindi,
    Hungarian,
    Icelandic,
    Indonesian,
    Irish,
    Italian,
    Japanese,
    Korean,
    Latvian,
    Lithuanian,
    Macedonian,
    Malay,
    Maltese,
    Norwegian,
    Persian,
    Polish,
    Portuguese,
    Romanian,
    Russian,
    Serbian,
    Slovak,
    Slovenian,
    Spanish,
    Swahili,
    Swedish,
    Thai,
    Turkish,
    Ukrainian,
    Vietnamese,
    Welsh,
    Yiddish
};

@interface CometChat : NSObject

/* Initialization method */
- (id)init;

/* Login with given URL and user-name */
- (void)loginWithURL:(NSString *)siteURL
              userID:(NSString *)userID
             success:(void(^)(NSDictionary *response))success
             failure:(void(^)(NSError *error))failure;

/* Login with given URL, username and password */
- (void)loginWithURL:(NSString *)siteURL
            username:(NSString *)username
            password:(NSString *)password
             success:(void(^)(NSDictionary *response))success
             failure:(void(^)(NSError *error))failure;

/* Login as guest with URL and name*/
- (void)guestLoginWithURL:(NSString *)siteURL
                     name:(NSString *)name
                  success:(void(^)(NSDictionary *response))success
                  failure:(void(^)(NSError *error))failure;

/* Subscribe to OneOnOne chat:
   with BOOL mode indicating whether to strip html tags or not */
- (void)subscribeWithMode:(BOOL)mode
         onMyInfoReceived:(void(^)(NSDictionary *response))myInfo
         onGetOnlineUsers:(void(^)(NSDictionary *response))onlineUsers
        onMessageReceived:(void(^)(NSDictionary *response))message
   onAnnouncementReceived:(void(^)(NSDictionary *response))announcement
  onAVChatMessageReceived:(void(^)(NSDictionary *response))avchatMessage
                  failure:(void(^)(NSError *error))failure;

/*  Send message to User */
- (void)sendMessage:(NSString *)message
             toUser:(NSString *)userID
            success:(void(^)(NSDictionary *response))response
            failure:(void(^)(NSError *error))failure;

/*   Send image to user with the given image path */
- (void)sendImageWithPath:(NSString *)imagePath
                   toUser:(NSString *)userID
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/*  Send image to user with given image data */
- (void)sendImageWithData:(NSData *)imageData
                   toUser:(NSString *)userID
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/*   Send video to user with the given video path */
- (void)sendVideoWithPath:(NSString *)videoPath
                   toUser:(NSString *)userID
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/*  Send video to user with given video data */
- (void)sendVideoWithURL:(NSURL *)videoURL
                   toUser:(NSString *)userID
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/* Change status of logged-in user. Refer to STATUS_OPTIONS enum in CometChat.h file for status values. */
- (void)changeStatus:(NSInteger)status
             success:(void(^)(NSDictionary *response))response
             failure:(void(^)(NSError *error))failure;

/* Change status message of logged-in user. */
- (void)changeStatusMessage:(NSString *)statusMessage
                    success:(void(^)(NSDictionary *response))response
                    failure:(void(^)(NSError *error))failure;


/* Get user information for userID */
- (void)getUserInfo:(NSString *)userID
            success:(void(^)(NSDictionary *response))response
            failure:(void(^)(NSError *error))failure;

/* Get online users of the site */
- (void)getOnlineUsersWithResponse:(void(^)(NSDictionary *response))response
                           failure:(void(^)(NSError *error))failure;

/* Get all announcements of the site */
- (void)getAllAnnouncements:(void (^)(NSDictionary *response))response
                    failure:(void (^)(NSError *error))failure;

/* Block User */
- (void)blockUser:(NSString *)userID
          success:(void(^)(NSDictionary *response))success
          failure:(void(^)(NSError *error))failure;

/* Unblock User */
- (void)unblockUser:(NSString *)userID
            success:(void(^)(NSDictionary *response))success
            failure:(void(^)(NSError *error))failure;

/* Delete User's History */
- (void)deleteUserHistory:(NSString *)userID
                  success:(void(^)(NSDictionary *response))success
                  failure:(void(^)(NSError *error))failure;

/* Get List of blocked users */
- (void)getBlockedUsersWithResponse:(void(^)(NSDictionary *response))success
                            failure:(void(^)(NSError *error))failure;

/* Get chat history of user specified by userID */
- (void)getChatHistoryOfUser:(NSString *)friendID
                   messageID:(NSString *)messageID
                     success:(void(^)(NSDictionary *response))success
                     failure:(void(^)(NSError *error))failure;

/* Translate OneOnOne and Chatroom Messages */
- (void)setTranslationLanguage:(NSInteger)language
                       success:(void(^)(NSDictionary *response))response
                       failure:(void(^)(NSError *error))failure;

/* Check whether the user is logged-in */
+ (BOOL)isLoggedIn DEPRECATED_MSG_ATTRIBUTE("This method is deprecated");

/* Unsubscribe from OneOnChat */
- (void)unsubscribe;

/* Logout */
- (void)logoutWithSuccess:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/* Returns the SDK version */
+ (NSString *)getSDKVersion;

/* Check CometChat installation directory */
- (void)isCometChatInstalled:(NSString *)siteURL
          success:(void(^)(NSDictionary *response))success
          failure:(void(^)(NSError *error))failure;

/* Set Development Mode */
+ (void)setDevelopmentMode:(BOOL)flag;

@end
