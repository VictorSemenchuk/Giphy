//
//  GiphyError.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "GiphyError.h"

static NSString * const appDomain = @"com.epam.giphy";

@interface GiphyError ()

+ (NSString *)localizedDescriptionForErrorCode:(GiphyErrorCode)errorCode;

@end

@implementation GiphyError

+ (instancetype)errorWithCode:(GiphyErrorCode)errorCode {
    GiphyError *error = [super errorWithDomain:appDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey: [GiphyError localizedDescriptionForErrorCode:errorCode]}];
    return error;
}

+ (NSString *)localizedDescriptionForErrorCode:(GiphyErrorCode)errorCode {
    switch (errorCode) {
        case kDownloadingError:
            return @"Downloading error";
        case kParsingErrorUnknownDataSnapshot:
            return @"Parsing error. Unknown data snapshot";
        case kParsingErrorInvalidData:
            return @"Parsing error. Invalid data";
        case kParsingErrorFailureSetDataToModel:
            return @"Parsing error. Can't set data to model";
        case kFetchingError:
            return @"Fetching error";
        case kDataErrorFailureGetAnimatedImage:
            return @"Can't get animated image";
        case kNoInternet:
            return @"The Internet is turn off. Turn on cellular or Wi-Fi to access data";
        default:
            return @"Unknow Error";
    }
}

@end
