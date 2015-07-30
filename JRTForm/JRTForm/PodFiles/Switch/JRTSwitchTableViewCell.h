//
//  JRTSwitchTableViewCell.h
//  
//
//  Created by Juan Garcia on 9/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;
#import "JRTBaseCell.h"
extern NSString * const JRTFormFieldSwitchTableViewCell;

@interface JRTSwitchTableViewCell : JRTBaseCell

@property (nonatomic) BOOL on;

- (void)setDefaultStyle;
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;

- (void)setErrorMessageInValidationBlock:   (NSString *(^)(BOOL boolToValidate))errorMessageInValidationBlock;

@end
