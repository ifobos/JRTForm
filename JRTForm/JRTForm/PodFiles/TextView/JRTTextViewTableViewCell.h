//
//  JRTTextViewTableViewCell.h
//  
//
//  Created by Juan Garcia on 7/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import UIKit;
#import "JRTBaseCell.h"

extern NSString * const JRTFormFieldTextViewTableViewCell;

@interface JRTTextViewTableViewCell : JRTBaseCell

@property (nonatomic, strong)   NSString * text;

- (void)setErrorMessageInValidationBlock:   (NSString *(^)(NSString * stringToValidate))errorMessageInValidationBlock;
- (void)setKeyboardType:                    (UIKeyboardType)keyboardType;

- (void)setDefaultStyle;
- (void)setEmptyStyle;
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;

#pragma mark - UITextViewDelegate

- (void)setDidEndEditing:                       (void (^)(UITextView * textView))didEndEditing;
- (void)setDidBeginEditing:                     (void (^)(UITextView * textView))didBeginEditing;
- (void)setDidChange:                           (BOOL (^)(UITextView * textView))didChange;
- (void)setDidChangeSelection:                  (BOOL (^)(UITextView * textView))didChangeSelection;
- (void)setShouldBeginEditing:                  (BOOL (^)(UITextView * textView))shouldBeginEditing;
- (void)setShouldEndEditing:                    (BOOL (^)(UITextView * textView))shouldEndEditing;
- (void)setShouldChangeText:                    (BOOL (^)(UITextView * textView, NSRange range, NSString * string))shouldChangeText;
- (void)setShouldInteractWithURL:               (BOOL (^)(UITextView * textView, NSURL * URL, NSRange characterRange))shouldInteractWithURL;
- (void)setShouldInteractWithTextAttachment:    (BOOL (^)(UITextView * textView, NSTextAttachment * textAttachment, NSRange characterRange))shouldInteractWithTextAttachment;

@end
