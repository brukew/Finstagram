//
//  DetailsViewController.h
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"
#import "Parse/PFCollectionViewCell.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewControllerDelegate

- (void)didLeave;

@end

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) Post *post;
@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel2;

@end

NS_ASSUME_NONNULL_END
