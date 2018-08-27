//
//  SearchResultsViewController+SearchResultsViewPresenterDelegate.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController+SearchResultsViewPresenterDelegate.h"

@implementation SearchResultsViewController (SearchResultsViewPresenterDelegate)

- (void)itemsWasFetched:(NSArray<GiphyData *> * _Nullable)items {
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

- (void)updateTitleWithText:(NSString *)text {
    self.title = text;
    self.navigationItem.title = text;
}

@end
