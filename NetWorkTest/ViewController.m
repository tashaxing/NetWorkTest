//
//  ViewController.m
//  NetWorkTest
//
//  Created by yxhe on 16/7/1.
//  Copyright © 2016年 yxhe. All rights reserved.
//

#import "ViewController.h"
#import "BasicNetworkViewController.h"
#import "AfnetworkViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Home";
    
    // -------- Add two buttons -------- //
    // The basic network button
    CGRect screenRect = self.view.frame;
    UIButton *basicNetworkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    basicNetworkBtn.frame = CGRectMake(screenRect.size.width / 2 - 80, 200, 160, 50);
    basicNetworkBtn.layer.masksToBounds = YES; // set the radius border
    basicNetworkBtn.layer.cornerRadius = 10.0;
    basicNetworkBtn.layer.borderWidth = 1.5;
    basicNetworkBtn.layer.borderColor = [[UIColor blueColor] CGColor];
    basicNetworkBtn.backgroundColor = [UIColor yellowColor];
    [basicNetworkBtn setTitle:@"basic network" forState:UIControlStateNormal];
    [basicNetworkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [basicNetworkBtn addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:basicNetworkBtn];
    // The Afnetworking button
    UIButton *afnetWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    afnetWorkBtn.frame = CGRectMake(screenRect.size.width / 2 - 80, 300, 160, 50);
    afnetWorkBtn.layer.masksToBounds = YES;
    afnetWorkBtn.layer.cornerRadius = 10.0;
    afnetWorkBtn.layer.borderWidth = 1.5;
    afnetWorkBtn.layer.borderColor = [[UIColor purpleColor] CGColor];
    afnetWorkBtn.backgroundColor = [UIColor yellowColor];
    [afnetWorkBtn setTitle:@"afnetworking" forState:UIControlStateNormal];
    [afnetWorkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [afnetWorkBtn addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:afnetWorkBtn];
    
    
    
}

- (void)onButtonClicked:(UIButton *)button
{
    // Navigate to different pages
    if([button.currentTitle isEqualToString:@"basic network"])
    {
        BasicNetworkViewController *basicNetworkViewController = [[BasicNetworkViewController alloc] init];
        [self.navigationController pushViewController:basicNetworkViewController animated:YES];
    }
    else if([button.currentTitle isEqualToString:@"afnetworking"])
    {
        AfnetworkViewController *afnetworkViewController = [[AfnetworkViewController alloc] init];
        [self.navigationController pushViewController:afnetworkViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
