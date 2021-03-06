//
//  GiphyCollectionViewLayout.h
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GiphyCollectionViewLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width;

@end

@interface GiphyCollectionViewLayout : UICollectionViewLayout

@property (weak, nonatomic) id<GiphyCollectionViewLayoutDelegate> delegate;

@end
