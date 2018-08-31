//
//  DetailsViewController.h
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralConstants.h"

@protocol DetailsViewProtocol

- (void)showActivityViewController:(UIActivityViewController *)activityViewController;
- (void)setIconForStartStopPlayingButton:(UIImage *)image;
- (void)updateSaveRemoveButton:(NSString *)title image:(UIImage *)image;

@end

@class DetailsViewPresenter;
@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *stopPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic) DetailsViewPresenter *presenter;

@end
