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
    [self.collectionView performBatchUpdates:^{
        NSInteger section = 0;
        NSMutableArray<NSIndexPath *> *indexPaths = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < items.count; i++) {
            [self.items addObject:items[i]];
            NSInteger row = self.items.count - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [indexPaths addObject:indexPath];
        }
        [self.collectionView insertItemsAtIndexPaths:indexPaths];
    } completion:nil];
}

@end
