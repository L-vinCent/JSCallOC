//
//  PPWebBridgeManager.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/6.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPWebBridgeManager.h"

#import "WKWebViewJavascriptBridge.h"

static PPWebBridgeManager *_instance;

@interface PPWebBridgeManager ()<WKNavigationDelegate>

@property(nonatomic,strong)WKWebView *baseWebview;

@property WKWebViewJavascriptBridge *webViewBridge;



@end

@implementation PPWebBridgeManager



-(WKWebView *)setWebviewWithFrame:(CGRect )frame url:(NSString *)urlStr
{
    

    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    

    
    
    //测试交互代码
    _baseWebview = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    
    NSString *urlStr1 = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    
    //    NSString *localHtml = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr1];
    [_baseWebview loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    _webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:_baseWebview];

    [_webViewBridge setWebViewDelegate:self];
    [self registFunction_all];
    

    
    return _baseWebview;
    
}


    
    
#pragma mark -注册所有JS 需要调用的函数
-(void)registFunction_all
{
    [self registShareFunction];
}




- (void)registShareFunction
{
    [_webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        NSString *title = [tempDic objectForKey:@"title"];
        NSString *content = [tempDic objectForKey:@"content"];
        NSString *url = [tempDic objectForKey:@"url"];
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        
        responseCallback(result);
        
        [self pp_hander];
        
    }];
}




//原生调用JS , JS 中先声明testJSFunction 函数
-(void)pp_hander
{
    
    //testJSFunction 是JS的方法
    [_webViewBridge callHandler:@"testJSFunction" data:@"一个字符串" responseCallback:^(id responseData) {
        
        NSLog(@"调用完JS后的回调：%@",responseData);
        
    }];
}





#pragma mark-创建单例
+(instancetype)shareInstance
{
   
    return [[self alloc]init];
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        if (_instance == nil) {
            
            _instance=[super allocWithZone:zone];
            
        }
        
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

@end
