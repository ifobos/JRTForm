//Copyright (c) 2015 Juan Carlos Garcia Alfaro. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "JRTFormOptionsTableViewController.h"
#import "JRTFormSelectTableViewCell.h"
#import "JRTFormActualViewController.h"

@interface JRTFormOptionsTableViewController ()

@property (nonatomic) BOOL externalNavigationController;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *selectedIndexes;

@end

@implementation JRTFormOptionsTableViewController

#pragma mark - Getters

- (NSMutableArray *)selectedIndexes {
    if (!_selectedIndexes) {
        _selectedIndexes = [NSMutableArray new];
    }
    return _selectedIndexes;
}

#pragma mark - Presenter

- (void)show {
    UIViewController *viewController = [JRTFormActualViewController actualViewController];
    
    if (viewController.navigationController) {
        self.externalNavigationController = YES;
        [viewController.navigationController pushViewController:self animated:YES];
    }
    else {
        self.externalNavigationController = NO;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
        navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [viewController presentViewController:navigationController animated:YES completion:nil];
    }
}

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.asignatedDelegate.selectedIndexes = self.selectedIndexes;
}

#pragma mark - setUp

- (void)setUp {
    if (!self.externalNavigationController) {
        UIBarButtonItem *dissmisButton = [[UIBarButtonItem alloc] initWithTitle:@" ﹀ " style:UIBarButtonItemStylePlain target:self action:@selector(dismissModalAction)];
        self.navigationItem.leftBarButtonItem = dissmisButton;
    }
    [self.selectedIndexes removeAllObjects];
    [self.selectedIndexes addObjectsFromArray:self.asignatedDelegate.selectedIndexes];
}

#pragma mark - Navigation

- (void)dismissModalAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.asignatedDelegate.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"optionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.asignatedDelegate.options objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.selectedIndexes indexOfObject:@(indexPath.row)] != NSNotFound) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        if (self.singleSelection) {
            for (NSNumber *indexSelected in self.selectedIndexes) {
                [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexSelected.intValue inSection:indexPath.section]].accessoryType = UITableViewCellAccessoryNone;
            }
            [self.selectedIndexes removeAllObjects];
        }
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if ([self.selectedIndexes indexOfObject:@(indexPath.row)] == NSNotFound) {
            [self.selectedIndexes addObject:@(indexPath.row)];
        }
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([self.selectedIndexes indexOfObject:@(indexPath.row)] != NSNotFound) {
            [self.selectedIndexes removeObject:@(indexPath.row)];
        }
    }
}

@end
