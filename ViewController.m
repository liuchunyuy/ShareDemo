//
//  ViewController.m
//  ShareDemo
//
//  Created by GavinHe on 2017/4/12.
//  Copyright © 2017年 Liu Chunyu. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createBtn];
    
}

-(void)createBtn{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 300, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"开始分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)go{

    NSArray* imageArray = @[[UIImage imageNamed:@"最新1.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        //[NSURL URLWithString:@"http://mob.com"]
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArray url:nil title:@"二维码"type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            NSLog(@"state is %lu",(unsigned long)state);
            NSLog(@"error is %@",error);
            switch (state) {
                case SSDKResponseStateBegin:{   // 开始
                    NSLog(@"开始");
                    break;
                }
                case SSDKResponseStateSuccess:{   // 分享成功
                    NSLog(@"成功");
                    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertview show];
                    break;
                }
                case SSDKResponseStateFail:{     // 分享失败
                    NSLog(@"error is %@",error);
                    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"分享失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertview show];
                    break;
                }
                default:
                    break;
            }
        }
         ];}
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
