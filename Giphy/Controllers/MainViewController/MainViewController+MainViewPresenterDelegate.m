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
    [self.items addObjectsFromArray:items];
    [self.collectionView reloadData];
}

@end
