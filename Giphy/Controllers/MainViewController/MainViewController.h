//
//  MainViewController.h
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiphyCollectionViewLayout.h"
#import "GiphyCollectionViewCell.h"
#import "IdentifierConstants.h"

@protocol MainViewProtocol <NSObject>

- (void)updateShowSavedButton:(UIImage *)image;

@end

@class MainViewPresenter;
@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *showSaved;
@property (weak, nonatomic) IBOutlet UITextField *searhTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) MainViewPresenter *presenter;

@end
