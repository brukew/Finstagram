//
//  EditProfileViewController.m
//  Finstagram
//
//  Created by Bruke Wossenseged on 7/9/21.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"

@interface EditProfileViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate >

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.profilePicView setUserInteractionEnabled:YES];
    [self.profilePicView  addGestureRecognizer:tapGestureRecognizer];
    
    self.bioTextView.delegate = self;
    
    PFUser *current = [PFUser currentUser];
    if (current[@"name"]){
        self.nameLabel.text = current[@"name"];
    }
    else {
        self.nameLabel.placeholder = @"Your name";
    }
    if (current[@"bio"]){
        self.bioTextView.text = current[@"bio"];
    }
    else {
        self.bioTextView.text = @"Placeholder";
        self.bioTextView.textColor = [UIColor lightGrayColor];
    }
    
    if (current[@"profilePic"]){
        PFFileObject * profileImage = current[@"profilePic"];
        NSURL * imageURL = [NSURL URLWithString:profileImage.url];
        [self.profilePicView setImageWithURL:imageURL];
    }
    // Do any additional setup after loading the view.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.bioTextView.textColor == [UIColor lightGrayColor]) {
        self.bioTextView.text = nil;
        self.bioTextView.textColor = [UIColor blackColor];
        }
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
    
    [self.profilePicView setImage:editedImage];
 

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)editProfile:(id)sender {
    PFUser *current = PFUser.currentUser;
    current[@"name"] = self.nameLabel.text;
    current[@"bio"] = self.bioTextView.text;
    NSData *imageData = UIImagePNGRepresentation(self.profilePicView.image);
    current[@"profilePic"] = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
