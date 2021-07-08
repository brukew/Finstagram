//
//  PostCell.m
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/6/21.
//

#import "PostCell.h"
#import "Parse/PFImageView.h"
#import "DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadData{
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
    self.captionLabel.text = self.post[@"caption"];
    self.userLabel.text = self.post[@"author"][@"username"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    //NSString *createdAtString = [formatter stringFromDate:self.post.createdAt];
    self.timestampLabel.text = [self.post.createdAt.shortTimeAgoSinceNow stringByAppendingString:@" ago"];
    
}

@end
