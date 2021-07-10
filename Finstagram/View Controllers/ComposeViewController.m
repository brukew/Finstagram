//
//  ComposeViewController.m
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/6/21.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *resizedImage;
@property (weak, nonatomic) IBOutlet UITextField *captionField;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) NSString *comeFrom;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.postImageView setUserInteractionEnabled:YES];
    [self.postImageView addGestureRecognizer:tapGestureRecognizer];
    self.captionField.placeholder = @"Write a caption...";
}

- (IBAction)photoTapped:(UITapGestureRecognizer *)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.resizedImage = [self resizeImage:editedImage withSize:CGSizeMake(398, 398)];
    
    self.postImageView.image = self.resizedImage;

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sharePost:(id)sender {
    [Post postUserImage: self.resizedImage withCaption: self.captionField.text withCompletion: nil];
    self.captionField.text = @"Write a caption...";
    [self.postImageView setImage:[UIImage imageNamed:@"image_placeholder.png"]];
    [self.delegate didShare];
    if ([self.comeFrom  isEqual: @"home"]){
        self.comeFrom = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.tabBarController setSelectedIndex:0];
    }
    
    
}

- (IBAction)cancelPost:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
