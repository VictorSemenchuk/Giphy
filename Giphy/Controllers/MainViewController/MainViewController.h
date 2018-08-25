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

static NSString * const kCellIdentifier = @"GiphyCollectionViewCell";

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *searhTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
