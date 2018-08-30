//
//  MainViewController+GiphyCollectionViewLayout.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController+GiphyCollectionViewLayout.h"
#import "Giphy-Swift.h"

@implementation MainViewController (GiphyCollectionViewLayout)

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    GiphyData *giphyItem = [self.presenter itemForIndexPath:indexPath];
    CGFloat tempHeight = [giphyItem.image.preview.height floatValue];
    CGFloat tempWidth = [giphyItem.image.preview.width floatValue];
    return tempHeight * width / tempWidth;
}

@end
