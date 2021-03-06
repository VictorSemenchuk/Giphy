//
//  DownloadManager.h
//  Giphy
//
//  Created by Viktar Semianchuk on 8/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiphyError.h"

@interface DownloadManager : NSObject

- (void)fetchDataFromURL:(NSString *)stringUrl withCompletionBlock:(void(^)(NSData *, GiphyError *))completionBlock;

@end
