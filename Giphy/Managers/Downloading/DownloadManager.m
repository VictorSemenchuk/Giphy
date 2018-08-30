//
//  DownloadManager.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DownloadManager.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation DownloadManager

- (void)fetchDataFromURL:(NSString *)stringUrl withCompletionBlock:(void (^)(NSData *, GiphyError *))completionBlock {
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:stringUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
    
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.waitsForConnectivity = YES;
    configuration.allowsCellularAccess = YES;
    configuration.URLCache = nil;
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration: configuration];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
            if (error != nil) {
                if ([error domain] == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet) {
                    completionBlock(nil, [GiphyError errorWithCode:kDownloadingError]);
                } else {
                    completionBlock(nil, [GiphyError errorWithCode:kDownloadingError]);
                }
            } else {
                completionBlock(data, nil);
            }
        });
    }];
    
    [task resume];
}

@end
