//
//  SettingsTableViewController.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "Giphy-Swift.h"

@interface SettingsTableViewController () <SettingsViewPresenterDelegate>

@property (nonatomic) SettingsViewPresenter *presenter;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[SettingsViewPresenter alloc] initWithView:self];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [Rating ratingTypesCount];
    } else {
        return 1;
    }
}

- (IBAction)dismissController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.blackColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    switch (indexPath.section) {
        case 0: {
            NSInteger checkedRow = [self.presenter getRattingSetting];
            cell.textLabel.text = [Rating stringDescriptionWithTypeFor:indexPath.row];
            cell.accessoryType = checkedRow == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            break;
        }
        case 1:
            cell.textLabel.text = @"Clear cache";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger oldCheckedRow = [self.presenter updateRatingSettingWithNewValue:indexPath.row];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:oldCheckedRow inSection:indexPath.section], [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    } else {
    }
    switch (indexPath.section) {
        case 0: {
            NSInteger oldCheckedRow = [self.presenter updateRatingSettingWithNewValue:indexPath.row];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:oldCheckedRow inSection:indexPath.section], [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case 1: {
            [self.presenter clearCache];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return @"Rating";
    case 1:
        return @"Options";
    default:
        return @"";
    }
}

@end
