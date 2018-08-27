//
//  DetailsViewController.h
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Giphy-Swift.h"

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *stopPlayButton;
@property (nonatomic) GiphyData *giphyItem;

@end
