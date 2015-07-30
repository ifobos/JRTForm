//
//  JRYOptionsTableViewController.m
//
//
//  Created by Juan Garcia on 9/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTOptionsTableViewController.h"
#import "JRTSelectTableViewCell.h"
#import "JRTActualViewController.h"

@interface JRTOptionsTableViewController ()
@property (nonatomic)BOOL externalNavigationController;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSMutableArray *selectedIndexes;
@end

@implementation JRTOptionsTableViewController

#pragma mark - Getters

-(NSMutableArray *)selectedIndexes
{
    if (!_selectedIndexes) _selectedIndexes = [NSMutableArray new];
    return _selectedIndexes;
}


#pragma mark - Presenter

- (void)show
{
    UIViewController *viewController = [JRTActualViewController actualViewController];
    
    if (viewController.navigationController)
    {
        self.externalNavigationController = YES;
        [viewController.navigationController pushViewController:self animated:YES];
    }
    else
    {
        self.externalNavigationController = NO;
        UINavigationController *navigationController    = [[UINavigationController alloc] initWithRootViewController:self];
        navigationController.modalPresentationStyle     = UIModalPresentationCurrentContext;
        [viewController presentViewController:navigationController animated:YES completion:nil];
    }
}

#pragma mark - ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.asignatedDelegate.selectedIndexes = self.selectedIndexes;
}

#pragma mark - setUp

- (void)setUp
{
    if (!self.externalNavigationController)
    {
        UIBarButtonItem *dissmisButton          = [[UIBarButtonItem alloc] initWithTitle:@" ⌵ " style:UIBarButtonItemStylePlain target:self action:@selector(dismissModalAction)];
        self.navigationItem.leftBarButtonItem   = dissmisButton;
    }
    [self.selectedIndexes removeAllObjects];
    [self.selectedIndexes addObjectsFromArray:self.asignatedDelegate.selectedIndexes];
}

#pragma mark - Navigation

- (void)dismissModalAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.asignatedDelegate.options count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier  = @"optionCell";
    UITableViewCell *cell                   = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) cell                   = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    cell.textLabel.text                     = [self.asignatedDelegate.options objectAtIndex:indexPath.row];
    cell.selectionStyle                     = UITableViewCellSelectionStyleNone;
    if ([self.selectedIndexes indexOfObject:@(indexPath.row)] != NSNotFound) cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        if (self.singleSelection)
        {
            for (NSNumber *indexSelected in self.selectedIndexes) [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexSelected.intValue inSection:indexPath.section]].accessoryType = UITableViewCellAccessoryNone;
            [self.selectedIndexes removeAllObjects];
        }
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if ([self.selectedIndexes indexOfObject:@(indexPath.row)] == NSNotFound) [self.selectedIndexes addObject:@(indexPath.row)];

    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([self.selectedIndexes indexOfObject:@(indexPath.row)] != NSNotFound) [self.selectedIndexes removeObject:@(indexPath.row)];
    }
}




@end
