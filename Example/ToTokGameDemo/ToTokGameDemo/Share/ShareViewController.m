//
//  ShareViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/3/26.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "ShareViewController.h"
#import "Header.h"

@interface ShareViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gameInviteHeight;
@property (weak, nonatomic) IBOutlet UIView *gameInviteView;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    if (self.userType == TTGCLoginType_Facebook) {
        self.gameInviteHeight.constant = 60;
        self.gameInviteView.hidden = NO;
    } else {
        self.gameInviteHeight.constant = 0;
        self.gameInviteView.hidden = YES;
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fblink:(id)sender {
    TTGCSocialFBInvite *obj = [[TTGCSocialFBInvite alloc] init];
    //obj.quote = @"Join us";
    [[ToTokGameManager defaultManager] facebookShareMessage:obj completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
        } else {
            if (error) {
                TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
            }
        }
    }];
}

- (IBAction)fbGameInviteFriends:(id)sender {
    TTGCSocialFBFriendsGameInvite *obj = [[TTGCSocialFBFriendsGameInvite alloc] init];
    obj.inviteString = @"join us";
    [[ToTokGameManager defaultManager] facebookShareMessage:obj completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            TTGCHUD_SUCCESS(@"sent the message");
        } else {
            if (error) {
                TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
            }
        }
    }];
}

- (IBAction)fbpic:(id)sender {
    //There are some bugs here that are being fixed.
    TTGCHUD_HINT(@"There are some bugs here that are being fixed.");
}

- (IBAction)walink:(id)sender {
    TTGCSocialWAInvite *obj = [[TTGCSocialWAInvite alloc] init];
    obj.contentString = @"play games";
    [[ToTokGameManager defaultManager] whatsAppShareMessage:obj completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
        } else {
            if (error) {
                TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
            }
        }
    }];
}

- (IBAction)wapic:(id)sender {
    [[ToTokGameManager defaultManager] openSystemPhotoCompletion:^(id  _Nullable mediaInfo, NSError * _Nullable error) {
        if (mediaInfo) {
            NSString *type = [mediaInfo objectForKey:@"MediaType"];
            if (type) {
                if ([type isEqualToString:@"public.image"]) {
                    
                    UIImage *image = [mediaInfo objectForKey:@"OriginalImage"];
                    if (image) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            TTGCSocialWAImages *obj = [[TTGCSocialWAImages alloc] init];
                            obj.photos = @[image];
                            [[ToTokGameManager defaultManager] whatsAppShareMessage:obj completion:^(BOOL success, NSError * _Nullable error) {
                                if (success) {
                                } else {
                                    if (error) {
                                        TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
                                    }
                                }
                            }];
                        });
                    } else {
                        TTGCHUD_HINT(@"the image is empty");
                    }
                    
                } else if ([type isEqualToString:@"public.movie"]) {
                    TTGCHUD_HINT(@"you seleced a video");
                }
            }
        }
    }];
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
