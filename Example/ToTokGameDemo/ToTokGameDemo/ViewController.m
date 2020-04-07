//
//  ViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/1/22.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "ViewController.h"
#import <ToTokGameSDK/ToTokGameSDK.h>

#import <SDWebImage/SDWebImage.h>
#import "TGWebViewController.h"

#import "Header.h"
#import "DevSettingViewController.h"
#import "PayViewController.h"
#import "ShareViewController.h"
#import "AboutViewController.h"

//UI配置
#define login_bg_alpha 0.6
#define loginview_bg_color @"#53ceca"
#define loginbutton_bg_color @"#42455c"
#define loginbutton_titile_color @"#ffffff"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *acountType;

@property (weak, nonatomic) IBOutlet UIButton *logButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation ViewController
{
    UIDeviceOrientation currentOrientation;
    
    UIView *loginbgView;
    UIView *loginView;
    UILabel *titileLabel;
    UIButton *guestButton;
    UIButton *gamecenterButton;
    UIButton *facebookButton;
    
    NSString *webtitle;
    
    TTGCUserModel *userModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationDidChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [self setupUI];
    [[ToTokGameManager defaultManager] setPayEnvironmentTest];
    [self showLoginView];
    
    [[ToTokGameManager defaultManager] accountKickedNotification:^(NSString * _Nullable information) {
        //Your account has been logged in on another device, please login again.
        TTGCHUD_HINT(information);
        [self showLoginView];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [[ToTokGameManager defaultManager] userInfoCompletion:^(id  _Nullable userInfo, NSError * _Nullable error) {
        if (!error) {
            self->userModel = userInfo;
            [self freshUserInfo:self->userModel];
        } else {
        }
    }];
}

- (void)setupUI {
    self.photoImageView.layer.cornerRadius = 49;
    self.photoImageView.clipsToBounds = YES;
    self.logButton.layer.cornerRadius = 4.0;
    self.logoutButton.layer.cornerRadius = 5.0;
}

- (void)showLoginView {
    if ([[ToTokGameManager defaultManager] loginType] == TTGCLoginType_unloggedIn) {
        //unlogged in and show login UI
        [self backgroundUI];
        [self loginView];
        [self.view bringSubviewToFront:self.logButton];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getUserInfo];
        });
    }
}

- (void)backgroundUI {
    loginbgView = [[UIView alloc] initWithFrame:self.view.bounds];
    loginbgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:login_bg_alpha];
    [self.view addSubview:loginbgView];
}

- (void)loginView {
    loginView = [[UIView alloc] init];
    loginView.backgroundColor = [self colorWithHexString:loginview_bg_color];
    loginView.layer.cornerRadius = 4.0;
    [loginbgView addSubview:loginView];
    
    NSString *titileString= @"Login";
    
    titileLabel = [[UILabel alloc] init];
    titileLabel.text = titileString;
    [loginView addSubview:titileLabel];
    
    [self loginButton];
    
    [self freshFrame];
}

- (void)loginButton {
    guestButton = [[UIButton alloc] init];
    gamecenterButton = [[UIButton alloc] init];
    facebookButton = [[UIButton alloc] init];
    
    NSString *guest = @"Guest Login";
    NSString *totok = @"Gamecenter Login";
    NSString *facebook = @"Facebook Login";
    [guestButton setTitle:guest forState:UIControlStateNormal];
    [guestButton addTarget:self action:@selector(guestLogin) forControlEvents:UIControlEventTouchUpInside];
    [gamecenterButton setTitle:totok forState:UIControlStateNormal];
    [gamecenterButton addTarget:self action:@selector(gamecenterLogin) forControlEvents:UIControlEventTouchUpInside];
    [facebookButton setTitle:facebook forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(facebookLogin) forControlEvents:UIControlEventTouchUpInside];
    [self buttonStyle:guestButton];
    [self buttonStyle:gamecenterButton];
    [self buttonStyle:facebookButton];
    
    [loginView addSubview:guestButton];
    [loginView addSubview:gamecenterButton];
    [loginView addSubview:facebookButton];
    
}

- (void)buttonStyle: (UIButton *)button {
    [button setBackgroundColor:[self colorWithHexString:loginbutton_bg_color]];
    [button setTitleColor:[self colorWithHexString:loginbutton_titile_color] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
}

- (void)freshFrame {
    loginbgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGFloat padding = 20;
    CGFloat ratio = 0.725;
    CGFloat width = SCREEN_WIDTH-2*padding;
    CGFloat height = width/ratio;
    if (!IsPortrait) {
        width = SCREEN_HEIGHT-2*padding;
        height = width*ratio;
    }
    CGFloat x = (SCREEN_WIDTH-width)/2.0;
    CGFloat y = (SCREEN_HEIGHT-height)/2.0;
    CGFloat H = 100;
    [loginView setFrame:CGRectMake(x, y, width, height)];
    [titileLabel sizeToFit];
    titileLabel.center = CGPointMake(width/2.0, 20);
    [guestButton setFrame:CGRectMake(0, 0, width/2.0, 35)];
    guestButton.center = CGPointMake(width/2.0, height/4.0);
    [gamecenterButton setFrame:CGRectMake(0, 0, width/2.0, 35)];
    gamecenterButton.center = CGPointMake(width/2.0, guestButton.frame.origin.y+H);
    [facebookButton setFrame:CGRectMake(0, 0, width/2.0, 35)];
    facebookButton.center = CGPointMake(width/2.0, gamecenterButton.frame.origin.y+H);
}

- (void)onDeviceOrientationDidChange {
    UIDevice *device = [UIDevice currentDevice];
    if (device.orientation == UIDeviceOrientationPortrait ||
        device.orientation == UIDeviceOrientationLandscapeLeft ||
        device.orientation == UIDeviceOrientationLandscapeRight) {
        if (currentOrientation) {
            if ([self isFreshFrameWithOrientation:device.orientation]) {
                [self freshFrame];
            }
        }
        currentOrientation = device.orientation;
    }
}

- (BOOL)isFreshFrameWithOrientation:(UIDeviceOrientation)orientation {
    if ((currentOrientation == UIDeviceOrientationPortrait) && (orientation != UIDeviceOrientationPortrait)) {
        return YES;
    } else if ((currentOrientation != UIDeviceOrientationPortrait) && (orientation == UIDeviceOrientationPortrait)) {
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)clearNotification:(id)sender {
    [[ToTokGameManager defaultManager] cleanNotification];
    TTGCHUD_SUCCESS(@"cleared~");
}

- (IBAction)systemNotificationSetting:(id)sender {
    [[ToTokGameManager defaultManager] systemNotificationSetting];
}

- (IBAction)devSetting:(id)sender {
    DevSettingViewController *vc = [[DevSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)purchase:(id)sender {
    PayViewController *vc = [[PayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)social:(id)sender {
    ShareViewController *vc = [[ShareViewController alloc] init];
    vc.userType = userModel.userType;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)about:(id)sender {
    AboutViewController *vc = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)guestLogin {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[ToTokGameManager defaultManager] guestLoginCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //登录成功
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //查看error信息
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (void)gamecenterLogin {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[ToTokGameManager defaultManager] loginWithGameCenterCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //登录成功
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //查看error信息
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (void)facebookLogin {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[ToTokGameManager defaultManager] loginWithFacebookCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //登录成功
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //查看error信息
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (void)getUserInfo {
    TTGCHUD_NO_Stop(@"loading...")
    [[ToTokGameManager defaultManager] userInfoCompletion:^(id  _Nullable userInfo, NSError * _Nullable error) {
        if (!error) {
            TTGCHUD_SUCCESS(@"success")
            self->userModel = userInfo;
            [self freshUserInfo:self->userModel];
        } else {
            //查看error信息
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (void)freshUserInfo:(TTGCUserModel *)model {
    if (model.userId) {
        self.userIdLabel.text = model.userId;
    }
    if (model.photoUrl) {
        NSURL *url = [[NSURL alloc] initWithString:model.photoUrl];
        [self.photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_icon_default"]];
    } else {
        self.photoImageView.image = [UIImage imageNamed:@"user_icon_default"];
    }
    if (model.nickname) {
        self.nicknameLabel.text = model.nickname;
    }
    
    if (model.userType == TTGCLoginType_ToTok) {
        self.acountType.text = @"ToTok";
    } else if (model.userType == TTGCLoginType_GameCenter) {
        self.acountType.text = @"GameCenter";
    } else if (model.userType == TTGCLoginType_Facebook) {
        self.acountType.text = @"Facebook";
    } else if (model.userType == TTGCLoginType_Guest) {
        self.acountType.text = @"Guest";
    } else {
        self.acountType.text = @"Unknow";
    }
    
}

- (void)closeLoginView {
    [loginbgView removeFromSuperview];
    [self getUserInfo];
}

- (IBAction)logout:(id)sender {
    TTGCHUD_NO_Stop(@"logout...")
    [[ToTokGameManager defaultManager] logout:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            TTGCHUD_SUCCESS(@"success")
            [self showLoginView];
        } else {
            NSLog(@"%@",error.userInfo);
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            red = 0 ; green = 0 ; blue = 0; alpha = 1;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}



@end
