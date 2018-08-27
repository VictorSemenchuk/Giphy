//
//  MainViewController.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewController+MainViewPresenterDelegate.h"
#import "MainViewController+GiphyCollectionViewLayout.h"
#import "MainViewController+Appearance.h"
#import "SearchResultsViewController.h"
#import "DetailsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [[NSMutableArray alloc] init];
    self.presenter = [[MainViewPresenter alloc] initWithView: self];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GiphyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    GiphyCollectionViewLayout *layout = (GiphyCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (layout != nil) {
        layout.delegate = self;
    }
    [self setupViews];
    [self.presenter fetchItemsWith:0];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSearchResultSegueIdentifier]) {
        if (![self.searhTextField.text isEqualToString:@""]) {
            SearchResultsViewController *searchVC = segue.destinationViewController;
            searchVC.searchRequest = self.searhTextField.text;
            [self.searhTextField resignFirstResponder];
        } else {
            return;
        }
    } else if ([segue.identifier isEqualToString:kDetailsSegueIdentifier]) {
        DetailsViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        detailVC.giphyItem = self.items[indexPath.row];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:kSearchResultSegueIdentifier]) {
        if ([self.searhTextField.text isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

@end
