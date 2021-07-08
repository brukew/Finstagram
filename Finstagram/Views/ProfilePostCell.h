//
//  ProfilePostCell.h
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Parse/PFCollectionViewCell.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfilePostCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) IBOutlet Post *post;

@end

NS_ASSUME_NONNULL_END
