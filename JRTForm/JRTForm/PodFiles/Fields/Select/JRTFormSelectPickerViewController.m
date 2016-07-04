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

#import "JRTFormSelectPickerViewController.h"
#import "JRTFormSelectTableViewCell.h"

@interface JRTFormSelectPickerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *selectedIndexes;
@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;
@property (nonatomic, readonly) NSArray *options;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation JRTFormSelectPickerViewController

#pragma mark - Getters

- (NSMutableArray *)selectedIndexes {
    if (!_selectedIndexes) {
        _selectedIndexes = [NSMutableArray new];
    }
    return _selectedIndexes;
}

- (NSArray *)options {
    if (!self.delegate.options) {
        if (self.delegate.fetchOptionsBlock) {
            [self.activityIndicator startAnimating];
            self.delegate.options = [NSArray new];
            __block typeof (self) blockSelf = self;
            void (^completionBlock) (NSArray <NSString *> *options) = ^void(NSArray <NSString *> *options){
                blockSelf.delegate.options = options;
                if (options.count > 0) {
                    [blockSelf.optionsTableView reloadData];
                }
                [blockSelf.activityIndicator stopAnimating];
            };
            
            self.delegate.fetchOptionsBlock(completionBlock);
        }
    }
    return self.delegate.options;
}

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    self.titleLabel.text = self.title;
    self.optionsTableView.tableFooterView = [UIView new];
    [self.selectedIndexes removeAllObjects];
    [self.selectedIndexes addObjectsFromArray:self.delegate.selectedIndexes];
}

#pragma mark - TableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"optionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.options objectAtIndex:indexPath.row];
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

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    self.delegate.selectedIndexes = self.selectedIndexes;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
