//
//  ViewController.m
//  testJBR
//
//  Created by Liao PanPan on 2017/4/8.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "ViewController.h"

#import "PPWebBridgeManager.h"

@interface ViewController ()<WKNavigationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WKWebView *web=[[PPWebBridgeManager shareInstance]setWebviewWithFrame:self.view.bounds url:@""];
    [self.view addSubview:web];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
