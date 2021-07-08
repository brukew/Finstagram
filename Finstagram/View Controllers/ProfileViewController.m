//
//  ProfileViewController.m
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/8/21.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "ProfilePostCell.h"
#import "Parse/PFImageView.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray  *arrayOfPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.usernameLabel.text = [PFUser currentUser].username;
    
    [self refresh];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = self.collectionView.frame.size.width / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);

}


- (void)refresh {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfilePostCell" forIndexPath:indexPath];
    
    cell.post = self.arrayOfPosts[indexPath.item];
    cell.postImage.file = cell.post[@"image"];
    [cell.postImage loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
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
