//
//  MainViewController+CollectionView.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController+CollectionView.h"
#import "UIColor+ThemeColors.h"

@implementation MainViewController (CollectionView)

//MARK:- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GiphyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomThemeColor];
    [cell startActivityIndicator];
    return cell;
}

//MARK:- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kDetailsSegueIdentifier sender:indexPath];
}

@end
