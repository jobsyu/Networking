//
//  NetWorking.m
//  NetWorking
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//
//@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=1&number=20"
#import "NetWorking.h"

@interface HttpRequest : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
// 传入的参数
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

// 传出的参数
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSError *error;

// 调用的块代码
@property (nonatomic, strong) CompletionHandler handler;

// 开始请求
- (void)start;
@end

@implementation HttpRequest

// 懒加载data
- (NSMutableData *)data {
    if (!_data) {
        _data = [NSMutableData data];
    }
    
    return _data;
}

- (void)start {
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:_url cachePolicy:_cachePolicy timeoutInterval:_timeoutInterval] delegate:self];
    [conn start];
}

#pragma mark NSURLConnection的代理方法
#pragma mark 请求失败返回错误信息
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _error = error;
}

#pragma mark 接收到响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _response = response;
    [self.data setLength:0];
}

#pragma mark 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

#pragma mark 请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 调用block传出参数
    _handler(_response, _data, _error);
}

@end

@implementation NetWorking

+ (void)sendAsychronousRequestWithUrl:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(CompletionHandler)completionHandler
{
    HttpRequest *hr = [[HttpRequest alloc] init];
    hr.cachePolicy = cachePolicy;
    hr.timeoutInterval = timeoutInterval;
    hr.url = url;
    hr.handler = completionHandler;
    [hr start];
}

+ (void)sendAsychronousRequestWithUrl:(NSURL *)url completionHandler:(CompletionHandler)completionHandler
{
    // 1.
    HttpRequest *hr = [[HttpRequest alloc] init];
    hr.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    hr.timeoutInterval = 30;
    hr.url = url;
    hr.handler = completionHandler;
    [hr start];
    
    // 2.通过类名调用
}

@end
