//
//  NetWorking.h
//  NetWorking
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求完成的块代码(响应头, 数据, 错误信息)
typedef void(^CompletionHandler)(NSURLResponse *response, NSData *data, NSError *error);

@interface NetWorking : NSObject

/** 发送异步请求
    传入的参数: 请求地址,缓存策略,超时时长,请求完成的block
 */
+ (void)sendAsychronousRequestWithUrl:(NSURL *)url  cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(CompletionHandler)completionHandler;

/** 发送异步请求
    传入参数: 请求地址, 请求完成的block
    缓存策略和超时时长都有默认值.
 */
+ (void)sendAsychronousRequestWithUrl:(NSURL *)url completionHandler:(CompletionHandler)completionHandler;

@end
