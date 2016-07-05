//
//  AfnetworkViewController.m
//  NetWorkTest
//
//  Created by yxhe on 16/7/4.
//  Copyright © 2016年 yxhe. All rights reserved.
//

#import "AfnetworkViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"
#import "UIImageView+AFNetworking.h"

@interface AfnetworkViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AfnetworkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = @"afnetwork";
    
    // Add test buttons
    CGRect mainRect = self.view.frame;
    UIButton *getTestBtn = [[UIButton alloc] init];
    getTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 80, 160, 20);
    [getTestBtn setTitle:@"GET test" forState:UIControlStateNormal];
    [getTestBtn addTarget:self action:@selector(httpGetTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getTestBtn];
    
    UIButton *postTestBtn = [[UIButton alloc] init];
    postTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 110, 160, 20);
    [postTestBtn setTitle:@"POST test" forState:UIControlStateNormal];
    [postTestBtn addTarget:self action:@selector(httpPostTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postTestBtn];
    
    UIButton *downLoadTestBtn = [[UIButton alloc] init];
    downLoadTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 140, 160, 20);
    [downLoadTestBtn setTitle:@"Download test" forState:UIControlStateNormal];
    [downLoadTestBtn addTarget:self action:@selector(downLoadTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downLoadTestBtn];
    
    UIButton *upLoadTestBtn = [[UIButton alloc] init];
    upLoadTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 170, 150, 20);
    [upLoadTestBtn setTitle:@"Uploadtest" forState:UIControlStateNormal];
    [upLoadTestBtn addTarget:self action:@selector(upLoadTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upLoadTestBtn];
    
    UIButton *netStateTestBtn = [[UIButton alloc] init];
    netStateTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 200, 150, 20);
    [netStateTestBtn setTitle:@"watchNetState" forState:UIControlStateNormal];
    [netStateTestBtn addTarget:self action:@selector(watchNetState) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:netStateTestBtn];
    
    UIButton *setUrlImgTestBtn = [[UIButton alloc] init];
    setUrlImgTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 230, 150, 20);
    [setUrlImgTestBtn setTitle:@"setUrlImage" forState:UIControlStateNormal];
    [setUrlImgTestBtn addTarget:self action:@selector(setUrlImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setUrlImgTestBtn];
    
}

- (UIImageView *)imageView
{
    if(!_imageView)
    {
        CGRect mainRect = self.view.frame;
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 300, mainRect.size.width, 240);
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark - network test callbacks
// Test GET
- (void)httpGetTest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // Must add this code, or error occurs
    // Prepare the URL, parameters can be add to URL (could be html, json, xml, plist address)
//    NSString *url = @"https:github.com";
    NSString *url = @"http://zhan.renren.com/ceshipost";
    NSDictionary *params = @{@"tagId":@"18924", @"from":@"template"}; // Params can be nil
    
    [manager GET:url
      parameters:params
        progress:^(NSProgress * _Nonnull downloadProgress) {
            // Process the progress here
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]); // Can also parse the json file here
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];
}

// Test POST
- (void)httpPostTest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // Must add this code, or error occurs
    // Prepare the URL and parameters
    NSString *url = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    NSDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"date":@"20131129", @"startRecord":@"1", @"len":@"5", @"udid":@"1234567890", @"terminalType":@"Iphone", @"cid":@"213"}];
    
    [manager GET:url
       parameters:params
         progress:^(NSProgress * _Nonnull uploadProgress) {
             // Do sth to process progress
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@", error.localizedDescription);
         }];
}

// Test Download
- (void)downLoadTest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // Set the download URL, could be any format file (jpg,zip,rar,png,mp3,avi.....)
    NSString *urlString = @"http://img.bizhi.sogou.com/images/1280x1024/2013/07/31/353911.jpg";
    NSURL *url = [NSURL URLWithString:urlString];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"current downloading progress:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // The download address
        NSLog(@"default address%@",targetPath);
        // Set the real save address instead of the temporary address
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // When downloaded, do sth
        NSLog(@"%@ file downloaded to %@", response, [filePath URLByAppendingPathComponent:response.suggestedFilename]);
        // In the main thread, update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // Do sth to process UI
        });
        
    }];
    // Launch the download task
    [downloadTask resume];
}

// Test Upload
- (void)upLoadTest
{
    // Can also use configuration initialize manager
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // Set the request
    NSString *urlString = @"http://www.freeimagehosting.net/upload.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];

    //Set data to be uploaded
    UIImage *image = [UIImage imageNamed:@"beauty.jpg"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    // Upload from data or file
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request
                                                               fromData:data
                                                               progress:^(NSProgress * _Nonnull uploadProgress) {
                                                                   NSLog(@"current uploading progress:%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                                                               } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                   // Do sth to response the success
                                                                   NSLog(@"%@", response);
                                                               }];
    // Launch upload
    [uploadTask resume];
}

// Test the net state watching
- (void)watchNetState
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      unkown
     AFNetworkReachabilityStatusNotReachable     = 0,       c
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       cellular
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       wifi
     };
     */
    
    // Once the network changed, this code works
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch(status)
        {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"unkown");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"unkown");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"cellular");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            default:
                NSLog(@"????");
                break;
        }
    }];
    // Must start monitoring
    [manager startMonitoring];
}

// Test set url image
- (void)setUrlImage
{
    // Should include a header file, and the image willed cached automatically
    NSString *imgURL = @"http://img.article.pchome.net/00/44/28/57/pic_lib/wm/7.jpg";
    [self.imageView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
