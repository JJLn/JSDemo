//
//  ViewController.m
//  JSDemo
//
//  Created by 王建 on 16/8/2.
//  Copyright © 2016年 千牛众泰. All rights reserved.
//
#import <JavaScriptCore/JavaScriptCore.h>

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic)  UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.webView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"调JS" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Second" ofType:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"jsBlock"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式二" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
        [alertView show];
        
        for (JSValue *jsVal in args) {
            NSLog(@"**%@", jsVal.toString);
        }
        
        NSLog(@"-------End Log-------");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rightAction
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
    [context evaluateScript:textJS];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    }
    return _webView;
}
@end
