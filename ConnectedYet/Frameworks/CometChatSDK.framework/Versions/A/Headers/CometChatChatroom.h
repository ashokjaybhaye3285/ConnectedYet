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

/* Enum for Chatroom Types */
typedef NS_ENUM (NSInteger, CHATROOM_TYPES) {
    
    PUBLIC_CHATROOM,
    PASSWORD_PROTECTED_CHATROOM,
    INVITE_ONLY_CHATROOM
};

@interface CometChatChatroom : NSObject

/* Subscribe to Chatroom chat:
   BOOL mode indicating whether to strip html tags or not */
- (void)subscribeToChatroomWithMode:(BOOL)mode
          onChatroomMessageReceived:(void(^)(NSDictionary *response))message
            onActionMessageReceived:(void(^)(NSDictionary *response))actionMessage
            onChatroomsListReceived:(void(^)(NSDictionary *response))chatroomList
      onChatroomMembersListReceived:(void(^)(NSDictionary *response))chatroomMembersList
            onAVChatMessageReceived:(void(^)(NSDictionary *response))avchatMessage
                            failure:(void(^)(NSError *error))failure;

/* Join chatroom:
   specify chatroomID and password */
- (void)joinChatroom:(NSString *)chatroomName chatroomID:(NSString *)chatroomID chatroomPassword:(NSString *)chatroomPassword
             success:(void(^)(NSDictionary *response))success
             failure:(void(^)(NSError *error))failure;

/* Create Chatroom having specified type, name and password */
- (void)createChatRoom:(NSString *)chatroomName OfType:(NSInteger)type withPassword:(NSString *)chatroomPassword
               success:(void(^)(NSDictionary *response))success
               failure:(void(^)(NSError *error))failure;

/* Delete Chatroom passing chatroomID */
- (void)deleteChatRoom:(NSString *)chatroomID
               success:(void(^)(NSDictionary *response))response
               failure:(void(^)(NSError *error))error;

/* Invite users to specified chatroom */
- (void)inviteUsers:(NSArray *)usersID toChatRoom:(NSString *)chatroomName withChatroomID:(NSString *)chatroomID
        failure:(void(^)(NSError *error))failure;

/* Send message to currently joined chatroom */
- (void)sendChatroomMessage:(NSString *)message
                  withsuccess:(void(^)(NSDictionary *response))success
                      failure:(void(^)(NSError *error))failure;

/*  Send image in chatroom with the given image path */
- (void)sendImageWithPath:(NSString *)imagePath
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/*  Send image in chatroom with given image data */
- (void)sendImageWithData:(NSData *)imageData
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/*  Send video in chatroom with the given image path */
- (void)sendVideoWithPath:(NSString *)videoPath
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/*  Send image in chatroom with given image data */
- (void)sendVideoWithURL:(NSURL *)videoURL
                  success:(void(^)(NSDictionary *response))response
                  failure:(void(^)(NSError *error))failure;

/* Get chatroom list from server */
- (void)getAllChatrooms:(void(^)(NSDictionary *chatroomList))response
                           failure:(void(^)(NSError *error))failure;

/* Leave currently joined chatroom */
- (void)leaveChatroom:(void(^)(NSError *error))failure;

/* Unsubscribe from chatroom */
- (void)unsubscribeFromChatRoom;

/* Get currently joined chatroom id */
- (void)getCurrentChatroom:(void(^)(NSDictionary *response))success
                   failure:(void(^)(NSError *error))failure;

/* Check whether the user is subscribed to given chatroom */
+ (BOOL)isSubscribedToChatroom:(NSString *)chatroomID;

/* Gives SHA1 value of specified string */
+(NSString *)getSHA1ValueOfString:(NSString *)string;

@end
