//
//  TTGCWebViewController.m
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/3/5.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "TGWebViewController.h"
#import <WebKit/WebKit.h>
#import "Header.h"

#define kTTGCBundleName @"ToTokGame"


@interface TGWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) CALayer *progressLayer;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation TGWebViewController

- (UIModalPresentationStyle)modalPresentationStyle{
    return UIModalPresentationFullScreen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigation];
    [self makeWebView];
}

- (void)navigation {
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Nav_StatusBar_Height)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.navTitle;
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.center = CGPointMake(SCREEN_WIDTH/2.0, StatusBar_Height + 22);
    [nav addSubview:titleLabel];
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBar_Height, 44, 44)];
    UIImage *icon = [UIImage imageWithContentsOfFile:[[self ToTokGameBundle] pathForResource:@"nav_back@3x" ofType:@"png"]];
    [back setImage:icon forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:back];
    [self.view addSubview:nav];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//TTGCBundle
- (NSBundle *)ToTokGameBundle {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:kTTGCBundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}

- (void)makeWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    configuration.preferences.minimumFontSize = 10;
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Nav_StatusBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-KBottomSpace_Height-Nav_StatusBar_Height) configuration:configuration];

    [self.view addSubview:self.webView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条
    UIView * progress = [[UIView alloc] initWithFrame:CGRectMake(0, Nav_StatusBar_Height, SCREEN_WIDTH, 2)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    // 隐式动画
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progressLayer = layer;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        self.progressLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSString * urlStr = webView.URL.absoluteString;
    NSLog(@"-------didStart：%@",urlStr);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSString * urlStr = webView.URL.absoluteString;
    NSLog(@"-------didFail：%@",urlStr);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSString * urlStr = webView.URL.absoluteString;
    NSLog(@"-------didCommit：%@",urlStr);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString * urlStr = webView.URL.absoluteString;
    NSLog(@"-------didFinish：%@",urlStr);
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSString * urlStr = webView.URL.absoluteString;
    NSLog(@"-------didFail：%@",urlStr);
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSString * urlStr = webView.URL.absoluteString;
    NSLog(@"-------didReceiveServerRedirect：%@",urlStr);
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"-------decidePolicy：%@",urlStr);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
