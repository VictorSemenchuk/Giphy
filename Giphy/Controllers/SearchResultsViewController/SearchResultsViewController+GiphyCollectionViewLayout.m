//
//  SearchResultsViewController+GiphyCollectionViewLayout.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController+GiphyCollectionViewLayout.h"

@implementation SearchResultsViewController (GiphyCollectionViewLayout)

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    GiphyData *giphyItem = self.items[indexPath.row];
    CGFloat tempHeight = [giphyItem.image.preview.height floatValue];
    CGFloat tempWidth = [giphyItem.image.preview.width floatValue];
    return tempHeight * width / tempWidth;
}

@end
