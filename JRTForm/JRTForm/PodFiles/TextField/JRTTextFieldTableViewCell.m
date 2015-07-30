//
//  JRTTextFieldTableViewCell.m
//  
//
//  Created by Juan Garcia on 1/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTTextFieldTableViewCell.h"

NSString * const JRTFormFieldTextFieldTableViewCell = @"JRTTextFieldTableViewCell";

@interface JRTTextFieldTableViewCell()<UITextFieldDelegate>

@property (strong, nonatomic)   IBOutlet UILabel *label;
@property (strong, nonatomic)   IBOutlet UITextField *textField;
@property (nonatomic, copy)     NSString * (^errorMessageInValidationBlock)     (NSString *stringToValidate);
@property (nonatomic, copy)     void (^didEndEditing)                           (UITextField *textField);
@property (nonatomic, copy)     void (^didBeginEditing)                         (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldBeginEditing)                      (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldEndEditing)                        (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldClear)                             (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldReturn)                            (UITextField *textField);
@property (nonatomic, copy)     BOOL (^shouldChangeCharacters)                  (UITextField *textField, NSRange range, NSString *string);

@end

@implementation JRTTextFieldTableViewCell

@synthesize name = _name;

#pragma mark - styles

- (void)setDefaultStyle
{
    self.label.textColor    = [UIColor darkGrayColor];
    self.label.hidden       = NO;
    self.label.text         = self.name;
}

- (void)setEmptyStyle
{
    self.label.textColor    = [UIColor darkGrayColor];
    self.label.hidden       = YES;
    self.label.text         = self.name;
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage
{
    self.label.textColor    = [UIColor redColor];
    self.label.hidden       = NO;
    self.label.text         = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
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

@end
