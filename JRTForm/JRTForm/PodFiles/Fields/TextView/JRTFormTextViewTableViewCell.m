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


#import "JRTFormTextViewTableViewCell.h"

NSString *const kJRTFormFieldTextViewTableViewCell = @"JRTFormTextViewTableViewCell";

@interface JRTFormTextViewTableViewCell () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic) BOOL hideableLabel;

@property (nonatomic, copy) NSString * (^errorMessageInValidationBlock) (NSString *stringToValidate);
@property (nonatomic, copy) void (^didEndEditing) (UITextView *textView);
@property (nonatomic, copy) void (^didBeginEditing) (UITextView *textView);
@property (nonatomic, copy) BOOL (^didChange) (UITextView *textView);
@property (nonatomic, copy) BOOL (^didChangeSelection) (UITextView *textView);
@property (nonatomic, copy) BOOL (^shouldBeginEditing) (UITextView *textView);
@property (nonatomic, copy) BOOL (^shouldEndEditing) (UITextView *textView);
@property (nonatomic, copy) BOOL (^shouldChangeText) (UITextView *textView, NSRange range, NSString *string);
@property (nonatomic, copy) BOOL (^shouldInteractWithURL) (UITextView *textView, NSURL *URL, NSRange characterRange);
@property (nonatomic, copy) BOOL (^shouldInteractWithTextAttachment) (UITextView *textView, NSTextAttachment *textAttachment, NSRange characterRange);

@end

@implementation JRTFormTextViewTableViewCell

@synthesize name = _name;


#pragma mark - View

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.hideableLabel = self.label.hidden;
    self.labelColor = self.label.textColor;
}

#pragma mark - styles

- (void)setDefaultStyle {
    if (self.labelColor) {
        self.label.textColor = self.labelColor;
    }
    self.label.text = self.name;
    self.placeholderLabel.hidden = YES;
    if (self.hideableLabel) {
        self.label.hidden = NO;
    }
}

- (void)setEmptyStyle {
    if (self.labelColor) {
        self.label.textColor = self.labelColor;
    }
    self.label.text = self.name;
    self.placeholderLabel.hidden = NO;
    if (self.hideableLabel) {
        self.label.hidden = YES;
    }
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage {
    if (self.labelColor) {
        self.label.textColor = [UIColor redColor];
    }
    self.label.text = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
    if (self.hideableLabel) {
        self.label.hidden = NO;
    }
}

- (void)updateStyle {
    self.textView.text = self.text;
    if (!self.isValid) {
        [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.text)];
    }
    else if (self.text && ![self.textView.text isEqualToString:@""]) {
        [self setDefaultStyle];
    }
    else {
        [self setEmptyStyle];
    }
}

#pragma mark - getter

- (NSString *)text {
    return [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isValid {
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock) {
        NSString *errorMessage = self.errorMessageInValidationBlock(self.text);
        if (errorMessage && ![errorMessage isEqualToString:@""]) {
            valid = NO;
        }
    }
    return valid;
}

#pragma mark - setters

- (void)setText:(NSString *)text {
    self.textView.text = text;
    [self updateStyle];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.placeholderLabel.text = name;
    self.label.text = name;
}

- (void)setPlaceholderColor:(UIColor *)color {
    self.placeholderLabel.textColor =  color;
}

#pragma mark - keyboard

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    [self.textView setKeyboardType:keyboardType];
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType {
    self.textView.returnKeyType = returnKeyType;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.shouldBeginEditing) {
        return self.shouldBeginEditing(textView);
    }
    else {
        return YES;
    }
} // return NO to disallow editing.

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (self.shouldEndEditing) {
        return self.shouldEndEditing(textView);
    }
    else {
        return YES;
    }
} // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.didBeginEditing) {
        self.didBeginEditing(textView);
    }
} // became first responder

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self updateStyle];
    if (self.didEndEditing) {
        self.didEndEditing(textView);
    }
} // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (NSEqualRanges(range, NSMakeRange(0, 0)) && [text length] == 1 && [textView.text length] == 0) {
        [self setDefaultStyle];
    }
    else if (NSEqualRanges(range, NSMakeRange(0, [textView.text length])) && [text length] == 0) {
        [self setEmptyStyle];
    }
    if (self.shouldChangeText) {
        return self.shouldChangeText(textView, range, text);
    }
    else {
        return YES;
    }
} // return NO to not change text

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text length] == 0) {
        [self.placeholderLabel setHidden:NO];
    }
    else {
        [self.placeholderLabel setHidden:YES];
    }
    if (self.didChange) {
        self.didChange(textView);
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (self.didChangeSelection) {
        self.didChangeSelection(textView);
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){
    if (self.shouldInteractWithURL) {
        return self.shouldInteractWithURL(textView, URL, characterRange);
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){
    if (self.shouldInteractWithTextAttachment) {
        return self.shouldInteractWithTextAttachment(textView, textAttachment, characterRange);
    }
    return YES;
}

#pragma mark - Methods

- (void)fieldBecomeFirstResponder {
    [self.textView becomeFirstResponder];
}

@end
