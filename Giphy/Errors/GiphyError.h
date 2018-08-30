//
//  GiphyError.h
//  Giphy
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GiphyErrorCode) {
    kDownloadingError = 101,
    kParsingErrorUnknownDataSnapshot,
    kParsingErrorInvalidData,
    kParsingErrorFailureSetDataToModel,
    kFetchingError,
    kDataErrorFailureGetAnimatedImage,
    kNoInternet
};

@interface GiphyError : NSError

+ (instancetype)errorWithCode:(GiphyErrorCode)errorCode;

@end
