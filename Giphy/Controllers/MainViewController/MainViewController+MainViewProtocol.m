//
//  MainViewController+MainViewProtocol.m
//  Giphy
//
//  Created by Victor Macintosh on 29/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController+MainViewProtocol.h"

@implementation MainViewController (MainViewProtocol)

- (void)updateShowSavedButton:(UIImage *)image {
    [self.showSaved setImage: image];
}

@end
