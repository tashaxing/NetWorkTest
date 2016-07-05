//
//  BasicNetworkViewController.m
//  NetWorkTest
//
//  Created by yxhe on 16/7/4.
//  Copyright © 2016年 yxhe. All rights reserved.
//

#import "BasicNetworkViewController.h"

@interface BasicNetworkViewController ()<NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation BasicNetworkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"basic network";
    
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
    
    UIButton *sessionDelegateTestBtn = [[UIButton alloc] init];
    sessionDelegateTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 140, 160, 20);
    [sessionDelegateTestBtn setTitle:@"UrlDelegate test" forState:UIControlStateNormal];
    [sessionDelegateTestBtn addTarget:self action:@selector(UrlSessionDelegateTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sessionDelegateTestBtn];
    
    UIButton *downLoadTestBtn = [[UIButton alloc] init];
    downLoadTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 170, 160, 20);
    [downLoadTestBtn setTitle:@"Download test" forState:UIControlStateNormal];
    [downLoadTestBtn addTarget:self action:@selector(downLoadTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downLoadTestBtn];
    
    UIButton *upLoadTestBtn = [[UIButton alloc] init];
    upLoadTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 200, 150, 20);
    [upLoadTestBtn setTitle:@"Uploadtest" forState:UIControlStateNormal];
    [upLoadTestBtn addTarget:self action:@selector(upLoadTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upLoadTestBtn];
    
    UIButton *downloadDelegateTestBtn = [[UIButton alloc] init];
    downloadDelegateTestBtn.frame = CGRectMake(mainRect.size.width / 2 - 80, 230, 150, 20);
    [downloadDelegateTestBtn setTitle:@"DownloadDele" forState:UIControlStateNormal];
    [downloadDelegateTestBtn addTarget:self
                                action:@selector(DownloadTaskTest)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadDelegateTestBtn];
    


}

// Set the imageview
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

#pragma mark - button callbacks
// Simple Get
- (void)httpGetTest
{
    // Any url will be ok, here we use a little more complex url and params
    NSString *httpUrl = @"http://apis.baidu.com/thinkpage/weather_api/suggestion";
    NSString *httpArg = @"location=beijing&language=zh-Hans&unit=c&start=0&days=3";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", httpUrl, httpArg]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // Add some extra params
    [request setHTTPMethod:@"GET"];
    [request addValue:@"7941288324b589ad9cf1f2600139078e" forHTTPHeaderField:@"apikey"];
    
    // Set the task, we can also use dataTaskWithUrl
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Do sth to process returend data
        if(!error)
        {
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        else
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    // Launch task
    [dataTask resume];
}

// Simple Post
- (void)httpPostTest
{
    NSURL *url = [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Do sth to process returend data
        if(!error)
        {
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        else
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

// Simple Download
- (void)downLoadTest
{
    NSURL *url = [NSURL URLWithString:@"http://pic1.desk.chinaz.com/file/10.03.10/5/rrgaos56_p.jpg"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Use download with request or url
    NSURLSessionDownloadTask *downloadPhotoTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Move the downloaded file to new path
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
        // Set the image
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"set the image");
//            self.imageView.image = downloadedImage; // set image from original location
            self.imageView.image = [UIImage imageWithContentsOfFile:path]; // set image from file system
        });
    }];

    [downloadPhotoTask resume];
}

// Simple Upload
- (void)upLoadTest
{
    NSURLSession *session = [NSURLSession sharedSession];
    // Set the url and params
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
    
    // Use download from data or file
    NSURLSessionUploadTask *uploadPhotoTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Do sth to process returend data
        if(!error)
        {
            NSLog(@"upload success");
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        else
        {
            NSLog(@"%@", error.localizedDescription);
        }

    }];
    
    [uploadPhotoTask resume];
}



#pragma mark - data task delegate
// Url session delegate
- (void)UrlSessionDelegateTest
{
    NSString *httpUrl = @"http://apis.baidu.com/thinkpage/weather_api/suggestion";
    NSString *httpArg = @"location=beijing&language=zh-Hans&unit=c&start=0&days=3";
    // Set session with configuration, use this way to set delegate
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", httpUrl, httpArg]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // Add some extra params
    [request setHTTPMethod:@"GET"];
    [request addValue:@"7941288324b589ad9cf1f2600139078e" forHTTPHeaderField:@"apikey"];
    
    // Set the task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    // Must allow the response of server, then we can receive data
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // Recevied data
    NSLog(@"data received---%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(!error)
    {
        NSLog(@"task completed!");
    }
    else
    {
        NSLog(@"%@", error.localizedDescription);
    }
}


#pragma mark - download task delegate
- (void)DownloadTaskTest
{
    NSURL *url = [NSURL URLWithString:@"http://pic1.desk.chinaz.com/file/10.03.10/5/rrgaos56_p.jpg"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Use download with request or url
    NSURLSessionDownloadTask *downloadPhotoTask = [session downloadTaskWithRequest:request];
    
    [downloadPhotoTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"set photo");
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Set image in the main thread
        self.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // Compute the download progress
    CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f",progress);
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
