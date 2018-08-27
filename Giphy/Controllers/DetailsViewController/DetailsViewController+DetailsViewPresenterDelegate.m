//
//  DetailsViewController+DetailsViewPresenterDelegate.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DetailsViewController+DetailsViewPresenterDelegate.h"

@implementation DetailsViewController (DetailsViewPresenterDelegate)

- (void)setPlayIconForStopPlayButton {
    [self.stopPlayButton setImage:[UIImage imageNamed:@"PlayIcon"] forState:UIControlStateNormal];
}

- (void)setStopIconForStopPlayButton {
    [self.stopPlayButton setImage:[UIImage imageNamed:@"StopIcon"] forState:UIControlStateNormal];
}

@end
