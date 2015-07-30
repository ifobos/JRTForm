//
//  JRYOptionsTableViewController.h
//  
//
//  Created by Juan Garcia on 9/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;
@protocol JRTOptionsTableViewControllerDelegate
@property (nonatomic, strong)NSArray *options;
@property (nonatomic, strong)NSArray *selectedIndexes;
@end

@interface JRTOptionsTableViewController : UITableViewController
@property (nonatomic, strong)id<JRTOptionsTableViewControllerDelegate> asignatedDelegate;
@property (nonatomic) BOOL singleSelection;
- (void)show;
@end
