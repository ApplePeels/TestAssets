//
//  TestViewController.m
//  TestFlutter
//
//  Created by wangxingming on 2020/6/3.
//  Copyright © 2020 wangxingming. All rights reserved.
//

#import "TestViewController.h"

#import "image.h"
//#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>
#import <Masonry/Masonry.h>

//@import Flutter;

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage* image = [Image getImage:@"car.png"];
//    UIImage* image = [UIImage imageNamed:@"car.png"];
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.center.equalTo(self.view);
    }];
//    FlutterEngine* engine = [[FlutterEngine alloc] initWithName:@"xxx.xx"];
//    [engine run];
//
//    [GeneratedPluginRegistrant registerWithRegistry:engine];
//
//
//    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        FlutterViewController* viewController = [[FlutterViewController alloc] initWithEngine:engine nibName:nil bundle:nil];
//        [self.navigationController pushViewController:viewController animated:NO];
////        [self presentViewController:viewController animated:YES completion:nil];
//    }];
//
//
//    [NSTimer scheduledTimerWithTimeInterval:10 repeats:NO block:^(NSTimer * _Nonnull timer) {
//            FlutterViewController* viewController = [[FlutterViewController alloc] init];
//            [self.navigationController pushViewController:viewController animated:NO];
//    //        [self presentViewController:viewController animated:YES completion:nil];
//        }];
//
    
//    UIView* mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    mainView.backgroundColor = [UIColor redColor];
//    self.view = mainView;
//    [self.view addSubview:mainView];
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
