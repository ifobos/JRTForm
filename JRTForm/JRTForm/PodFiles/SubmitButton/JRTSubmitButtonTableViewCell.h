//
//  JRTSubmitButtonTableViewCell.h
//  
//
//  Created by Juan Garcia on 21/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;
#import "JRTBaseCell.h"
extern NSString * const JRTFormFieldSubmitButtonTableViewCell;

@interface JRTSubmitButtonTableViewCell : JRTBaseCell
@property (nonatomic, strong)NSMutableArray *fields;
@property (nonatomic, strong)NSString *errorMessage;

- (void)setSubmitBlock:(void (^)(NSArray *fieldCells))submitBlock;

- (void)setButtonBackgroundColor:(UIColor *)color;
- (void)setButtonTittleColor:(UIColor *)color;

- (void)setDefaultStyle;
- (void)setErrortStyle;

@end
