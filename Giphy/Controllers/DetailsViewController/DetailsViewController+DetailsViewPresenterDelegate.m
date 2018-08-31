//
//  DetailsViewController+DetailsViewPresenterDelegate.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DetailsViewController+DetailsViewPresenterDelegate.h"

@implementation DetailsViewController (DetailsViewPresenterDelegate)

- (void)showActivityViewController:(UIActivityViewController *)activityViewController {
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)setIconForStartStopPlayingButton:(UIImage *)image { 
    [self.stopPlayButton setImage:image forState:UIControlStateNormal];
}

- (void)updateSaveRemoveButton:(NSString *)title image:(UIImage *)image {
    [self.saveButton setTitle:title forState:UIControlStateNormal];
    [self.saveButton setImage:image forState:UIControlStateNormal];
}

@end
