//
//  ViewController.m
//  NetWorking
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 yangxin. All rights reserved.
//

#import "ViewController.h"
#import "NetWorking.h"

@interface ViewController ()
{
    UIImageView *_iv;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubviews];
}

- (void)createSubviews {
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    iv.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:iv];
    _iv = iv;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 320, 300, 40)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"开始异步请求" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(netWorking) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)netWorking {
    [NetWorking sendAsychronousRequestWithUrl:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/huaqiangu0701.jpg"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30 completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            _iv.image = [UIImage imageWithData:data];
        }
    }];
    
}

@end
