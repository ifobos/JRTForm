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


@import UIKit;
#import "JRTFormBaseCell.h"

extern NSString *const kJRTFormFieldTextViewTableViewCell;

@interface JRTFormTextViewTableViewCell : JRTFormBaseCell

@property (nonatomic, strong)   NSString *text;

- (void)setErrorMessageInValidationBlock:(NSString *(^)(NSString *stringToValidate))errorMessageInValidationBlock;
- (void)setKeyboardType:(UIKeyboardType)keyboardType;
- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType;
- (void)setPlaceholderColor:(UIColor *)color;

- (void)setDefaultStyle;
- (void)setEmptyStyle;
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;

- (void)fieldBecomeFirstResponder;


#pragma mark - UITextViewDelegate

- (void)setDidEndEditing:(void (^)(UITextView *textView))didEndEditing;
- (void)setDidBeginEditing:(void (^)(UITextView *textView))didBeginEditing;
- (void)setDidChange:(BOOL (^)(UITextView *textView))didChange;
- (void)setDidChangeSelection:(BOOL (^)(UITextView *textView))didChangeSelection;
- (void)setShouldBeginEditing:(BOOL (^)(UITextView *textView))shouldBeginEditing;
- (void)setShouldEndEditing:(BOOL (^)(UITextView *textView))shouldEndEditing;
- (void)setShouldChangeText:(BOOL (^)(UITextView *textView, NSRange range, NSString *string))shouldChangeText;
- (void)setShouldInteractWithURL:(BOOL (^)(UITextView *textView, NSURL *URL, NSRange characterRange))shouldInteractWithURL;
- (void)setShouldInteractWithTextAttachment:(BOOL (^)(UITextView *textView, NSTextAttachment *textAttachment, NSRange characterRange))shouldInteractWithTextAttachment;

@end
