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


#import "JRTFormTextFieldTableViewCell.h"

NSString * const kJRTFormFieldTextFieldTableViewCell = @"JRTFormTextFieldTableViewCell";

@interface JRTFormTextFieldTableViewCell()<UITextFieldDelegate>

@property (strong, nonatomic)   IBOutlet UILabel        *label;
@property (strong, nonatomic)   IBOutlet UITextField    *textField;
@property (nonatomic, strong)   UIColor                 *labelColor;
@property (nonatomic        )   BOOL                    hideableLabel;

@property (nonatomic, copy)     NSString * (^errorMessageInValidationBlock)     (NSString *stringToValidate);
@property (nonatomic, copy)     void (^didEndEditing)                           (UITextField *textField);
@property (nonatomic, copy)     void (^didBeginEditing)                         (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldBeginEditing)                      (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldEndEditing)                        (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldClear)                             (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldReturn)                            (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldChangeCharacters)                  (UITextField *textField, NSRange range, NSString *string);

@end

@implementation JRTFormTextFieldTableViewCell

@synthesize name = _name;

#pragma mark - View

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.hideableLabel  = self.label.hidden;
    self.labelColor     = self.label.textColor;
}

#pragma mark - styles

- (void)setDefaultStyle
{
    if(self.labelColor)
    self.label.textColor    = self.labelColor;
    self.label.text         = self.name;
    if(self.hideableLabel)
        self.label.hidden   = NO;
}

- (void)setEmptyStyle
{
    if(self.labelColor)
    self.label.textColor    = self.labelColor;
    self.label.text         = self.name;
    if (self.hideableLabel)
        self.label.hidden   = YES;
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage
{
    if(self.labelColor)
    self.label.textColor    = [UIColor redColor];
    self.label.text         = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
    if (self.hideableLabel)
        self.label.hidden   = NO;
}

- (void) updateStyle
{
    self.textField.text = self.text;
    if (!self.isValid) [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.text)];
    else if (self.text && ![self.text isEqualToString:@""]) [self setDefaultStyle];
    else [self setEmptyStyle];
}

#pragma mark - getter

- (NSString *)text
{
    return  [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isValid
{
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock)
    {
        NSString * errorMessage = self.errorMessageInValidationBlock(self.text);
        if (errorMessage && ![errorMessage isEqualToString:@""]) valid = NO;
    }
    return valid;
}

#pragma mark - setters

- (void)setText:(NSString *)text
{
    self.textField.text = text;
    [self updateStyle];
}

- (void)setName:(NSString *)name
{
    _name                       = name;
    self.textField.placeholder  = name;
    self.label.text             = name;
}

#pragma mark - keyboard

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    [self.textField setKeyboardType:keyboardType];
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    self.textField.returnKeyType = returnKeyType;
}

#pragma mark - secure

- (void)setSecureTextEntry:(BOOL)secure
{
    [self.textField setSecureTextEntry:secure];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.shouldBeginEditing) return self.shouldBeginEditing(textField);
    else return YES;
} // return NO to disallow editing.

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.didBeginEditing) self.didBeginEditing(textField);
} // became first responder

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.shouldEndEditing) return self.shouldEndEditing(textField);
    else return YES;
} // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateStyle];
    if (self.didEndEditing) self.didEndEditing(textField);
} // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (NSEqualRanges(range, NSMakeRange(0, 0)) && [string length] == 1 && [textField.text length] == 0) [self setDefaultStyle];
    else if (NSEqualRanges(range, NSMakeRange(0, [textField.text length])) && [string length] == 0) [self setEmptyStyle];
    if (self.shouldChangeCharacters) return self.shouldChangeCharacters(textField,range,string);
    else return YES;
} // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.shouldClear) return self.shouldClear(textField);
    else return YES;
} // called when clear button pressed. return NO to ignore (no notifications)

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.shouldReturn) return self.shouldReturn(textField);
    else return YES;
} // called when 'return' key pressed. return NO to ignore.

#pragma mark - Methods

- (void)fieldBecomeFirstResponder
{
    [self.textField becomeFirstResponder];
}

@end
