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

//MARK:- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kDetailsSegueIdentifier sender:indexPath];
}

@end
