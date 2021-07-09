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
#import <QuartzCore/QuartzCore.h>
#import "DetailsViewController.h"

@interface ProfileViewController () <DetailsViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray  *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;
@property (weak, nonatomic) IBOutlet UIView *profView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.usernameLabel.text = [PFUser currentUser].username;
    
    [self refresh];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:refreshControl atIndex:0];
    
    CALayer *bottomBorder = [CALayer layer];

    bottomBorder.frame = CGRectMake(0.0f, 0.0f, self.collectionView.frame.size.width, 1.0f);

    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;

    [self.collectionView.layer addSublayer:bottomBorder];
//
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
            
    layout.minimumInteritemSpacing = 2.5;
    layout.minimumLineSpacing = 2.5;
    
    CGFloat postsPerRow = 3;
    CGFloat itemWidth = (self.view.frame.size.width - layout.minimumInteritemSpacing * (postsPerRow - 1)) / postsPerRow;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self refresh];
    [refreshControl endRefreshing];
}


- (void)refresh {
    PFUser *current = [PFUser currentUser];

    if (current[@"name"]){
        self.nameLabel.text = current[@"name"];
    }
    if (current[@"bio"]){
        self.bioLabel.text = current[@"bio"];
    }
    
    if (current[@"profilePic"]){
        self.profilePicView.file = current[@"profilePic"];
        [self.profilePicView loadInBackground];
    }
    
    PFQuery *postQuery = [Post query];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            self.postCountLabel.text = [NSString stringWithFormat: @"%ld", (long)self.arrayOfPosts.count];
            [self.collectionView reloadData];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"detailsFromProfileSegue"]){
        UICollectionViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.post = self.arrayOfPosts[indexPath.item];
        detailsController.delegate = self;
    
}
}


- (void)didLeave {
    
}


@end
