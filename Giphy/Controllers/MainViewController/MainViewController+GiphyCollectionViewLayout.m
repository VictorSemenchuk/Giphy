//
//  MainViewController+GiphyCollectionViewLayout.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController+GiphyCollectionViewLayout.h"

@implementation MainViewController (GiphyCollectionViewLayout)

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath {
    return 40 + arc4random() % (150 - 40);
}

@end
