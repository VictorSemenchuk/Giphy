//
//  SearchResultsViewController.h
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiphyCollectionViewLayout.h"
#import "GiphyCollectionViewCell.h"
#import "IdentifierConstants.h"
#import "Giphy-Swift.h"

@interface SearchResultsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSString *searchRequest;
@property (nonatomic) NSMutableArray<GiphyData *> *items;
@property (nonatomic) SearchResultsViewPresenter *presenter;

@end
