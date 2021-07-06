//
//  ComposeViewController.h
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didShare:(Post *)post;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
