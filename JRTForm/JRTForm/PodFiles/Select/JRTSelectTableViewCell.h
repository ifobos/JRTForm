//
//  JRTMultiselectTableViewCell.h
//
//
//  Created by Juan Garcia on 9/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;
#import "JRTBaseCell.h"

extern NSString * const JRTFormFieldSelectTableViewCell;

@interface JRTSelectTableViewCell : JRTBaseCell
@property (nonatomic, strong)NSArray *options;
@property (nonatomic, strong)NSArray *selectedIndexes;

@property (nonatomic) BOOL singleSelection;
@property (nonatomic, readonly) NSNumber *selectedIndex;

- (void)setErrorMessageInValidationBlock:   (NSString *(^)(NSArray *arrayToValidate))errorMessageInValidationBlock;

- (void)setDefaultStyle;
- (void)setEmptyStyle;
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;

@end
