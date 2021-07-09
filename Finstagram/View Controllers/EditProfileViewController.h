//
//  EditProfileViewController.h
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
#import "Parse/PFCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;

@end

NS_ASSUME_NONNULL_END
