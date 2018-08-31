//
//  SettingsTableViewController.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "Giphy-Swift.h"

static NSString * const kTableViewCellIdentifier = @"tableViewIdentifier";

@interface SettingsTableViewController ()

@property (nonatomic) SettingsViewPresenter *presenter;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[SettingsViewPresenter alloc] init];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kTableViewCellIdentifier];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = UIColor.blackColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    switch (indexPath.section) {
        case 0: {
            NSInteger checkedRow = [self.presenter getRattingSetting];
            cell.textLabel.text = [Rating stringDescriptionWithTypeFor:indexPath.row];
            cell.accessoryType = checkedRow == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            cell.tintColor = [UIColor colorWithRed:191.0/255.0 green:0.0/255.0 blue:253.0/255.0 alpha:255.0/255.0];
            break;
        }
        case 1:
            cell.textLabel.text = @"Clear cache";
            cell.textLabel.textColor = [UIColor colorWithRed:191.0/255.0 green:0.0/255.0 blue:253.0/255.0 alpha:255.0/255.0];
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
