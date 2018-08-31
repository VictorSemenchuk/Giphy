//
//  MainViewController.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewController+GiphyCollectionViewLayout.h"
#import "MainViewController+MainViewProtocol.h"
#import "MainViewController+FetchViewProtocol.h"
#import "MainViewController+Appearance.h"
#import "SearchResultsViewController.h"
#import "DetailsViewController.h"
#import "Giphy-Swift.h"

@interface MainViewController ()

@end

@implementation MainViewController

//MARK:- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GiphyCollectionViewLayout *layout = (GiphyCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (layout != nil) {
        layout.delegate = self;
    }
    [self setupViews];
    
    self.presenter = [[MainViewPresenter alloc] init];
    self.collectionView.dataSource = self.presenter;
    [self.presenter registerCellsFor:self.collectionView];
    [self.presenter fetchItemsWith:0 for:self.collectionView by:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.presenter refetchSavedItemsFor:self.collectionView];
}

//MARK:- Segues

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
        detailVC.presenter = [[DetailsViewPresenter alloc] initWith:[self.presenter itemForIndexPath:indexPath]];
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

- (IBAction)toggleSavedFlag:(id)sender {
    [self.presenter toggleShowingSavedItemsFlagWithView:self for:self.collectionView];
}

@end
