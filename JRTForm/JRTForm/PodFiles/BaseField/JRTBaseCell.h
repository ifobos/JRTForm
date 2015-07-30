//
//  JRTBaseCell.h
//  
//
//  Created by Juan Garcia on 13/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;

@interface JRTBaseCell : UITableViewCell
@property (nonatomic, readonly) BOOL isValid;
@property (nonatomic, strong)   NSString *name;
- (UITableView *)superTableView;
- (void)updateStyle;
@end
