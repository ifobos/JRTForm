//
//  JRTTextFieldTableViewCell.h
//  
//
//  Created by Juan Garcia on 1/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;
#import "JRTBaseCell.h"

extern NSString * const JRTFormFieldTextFieldTableViewCell;

@interface JRTTextFieldTableViewCell : JRTBaseCell

@property (nonatomic, strong) NSString * text;

- (void)setErrorMessageInValidationBlock:   (NSString *(^)(NSString * stringToValidate))errorMessageInValidationBlock;
- (void)setKeyboardType:                    (UIKeyboardType)keyboardType;
- (void)setSecureTextEntry:                 (BOOL)secure;

- (void)setDefaultStyle;
- (void)setEmptyStyle;
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;

#pragma mark - UITextFieldDelegate

- (void)setDidEndEditing:           (void (^)(UITextField * textField))didEndEditing;
- (void)setDidBeginEditing:         (void (^)(UITextField * textField))didBeginEditing;
- (void)setShouldBeginEditing:      (BOOL (^)(UITextField * textField))shouldBeginEditing;
- (void)setShouldEndEditing:        (BOOL (^)(UITextField * textField))shouldEndEditing;
- (void)setShouldClear:             (BOOL (^)(UITextField * textField))shouldClear;
- (void)setShouldReturn:            (BOOL (^)(UITextField * textField))shouldReturn;
- (void)setShouldChangeCharacters:  (BOOL (^)(UITextField * textField, NSRange range, NSString * string))shouldChangeCharacters;

@end
