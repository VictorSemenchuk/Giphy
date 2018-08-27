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

//MARK:- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == (self.items.count - 1)) {
        [self.presenter fetchItemsBySearchRequest:self.searchRequest with:indexPath.row + 1];
    }
    GiphyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomThemeColor];
    [cell startActivityIndicator];
    [self.presenter fetchPreviewImageForGiphyItem:self.items[indexPath.row] completion:^(UIImage * _Nullable image) {
        cell.imageView.image = image;
        [cell stopActivityIndicator];
    }];
    return cell;
}

//MARK:- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kDetailsSegueIdentifier sender:indexPath];
}

@end
