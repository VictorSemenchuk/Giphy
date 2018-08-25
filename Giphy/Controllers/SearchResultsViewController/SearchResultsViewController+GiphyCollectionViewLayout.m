//
//  SearchResultsViewController+GiphyCollectionViewLayout.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController+GiphyCollectionViewLayout.h"

@implementation SearchResultsViewController (GiphyCollectionViewLayout)

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath {
    return 40 + arc4random() % (150 - 40);
}

@end
