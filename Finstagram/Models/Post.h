
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nonnull postID;
@property (nonatomic, strong) NSString * _Nonnull userID;
@property (nonatomic, strong) PFUser * _Nonnull author;

@property (nonatomic, strong) NSString * _Nonnull caption;
@property (nonatomic, strong) PFFileObject * _Nullable image;
@property (nonatomic, strong) NSNumber * _Nullable likeCount;
@property (nonatomic, strong) NSNumber * _Nullable commentCount;


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
