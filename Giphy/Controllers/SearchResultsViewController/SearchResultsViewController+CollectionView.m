//
//  SearchResultsViewController+CollectionView.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController+CollectionView.h"
#import "UIColor+ThemeColors.h"

@implementation SearchResultsViewController (CollectionView)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GiphyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomThemeColor];
    [cell startActivityIndicator];
    return cell;
}

@end
