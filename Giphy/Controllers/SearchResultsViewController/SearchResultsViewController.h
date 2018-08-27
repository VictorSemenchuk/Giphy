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

@interface SearchResultsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSString *searchRequest;

@end
