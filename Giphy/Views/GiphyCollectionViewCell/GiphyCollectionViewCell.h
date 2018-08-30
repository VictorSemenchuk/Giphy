//
//  GiphyCollectionViewCell.h
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiphyData;
@interface GiphyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)startActivityIndicator;
- (void)stopActivityIndicator;
- (void)setupViewsForGiphyItem:(GiphyData *)giphyItem sender:(NSObject *)sender;

@end
