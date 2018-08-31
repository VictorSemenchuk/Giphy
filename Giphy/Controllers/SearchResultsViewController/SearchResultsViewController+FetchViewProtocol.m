//
//  SearchResultsViewController+FetchViewProtocol.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/31/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController+FetchViewProtocol.h"

@implementation SearchResultsViewController (FetchViewProtocol)

- (void)showMessageLabelWithText:(NSString * _Nonnull)text {
    self.messageLabel.text = text;
    self.messageLabel.hidden = NO;
}

- (void)startActivityIndicator {
    [self.activityIndicator startAnimating];
}

- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
}

@end
