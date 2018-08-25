//
//  MainViewController+Appearance.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController+Appearance.h"
#import "Giphy-Swift.h"

@implementation MainViewController (Appearance)

- (void)setupViews {
    //searchTextField
    [self.searhTextField setLeftPaddingPoints:10];
    
    //navigationBar
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Giphy_Logo"]];
    
    //collectionView
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

@end
