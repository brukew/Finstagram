//
//  DetailsViewController.m
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/7/21.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
    self.captionLabel.text = self.post[@"caption"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    NSString *createdAtString = [formatter stringFromDate:self.post.createdAt];
    self.timestampLabel.text = createdAtString;
    self.userLabel.text = self.post[@"author"][@"username"];
    self.userLabel2.text = self.post[@"author"][@"username"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
