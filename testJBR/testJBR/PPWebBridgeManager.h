//
//  PPWebBridgeManager.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/6.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface PPWebBridgeManager : NSObject

+(instancetype)shareInstance;

-(WKWebView *)setWebviewWithFrame:(CGRect )frame url:(NSString *)urlStr;


@end
