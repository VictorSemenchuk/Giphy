//
//  MainViewController+MainViewPresenterDelegate.m
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController+MainViewPresenterDelegate.h"

@implementation MainViewController (MainViewPresenterDelegate)

- (void)itemsWasFetched:(NSArray<GiphyData *> *)items {
    //NSUInteger firstNewIndex = self.items.count;
//    [self.items addObjectsFromArray:items];
//    [self.collectionView reloadData];
    for (NSUInteger i = 0; i < items.count; i++) {
        [self.collectionView performBatchUpdates:^{
            [self.items addObject:items[i]];
            NSInteger row = self.items.count - 1;
            NSInteger section = 0;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        } completion:nil];
    }
}

@end
