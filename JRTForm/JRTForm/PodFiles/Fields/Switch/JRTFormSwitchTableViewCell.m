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

#import "JRTFormSwitchTableViewCell.h"

NSString *const kJRTFormFieldSwitchTableViewCell = @"JRTFormSwitchTableViewCell";

@interface JRTFormSwitchTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UISwitch *pickerSwitch;

@property (nonatomic, copy) NSString * (^errorMessageInValidationBlock) (BOOL boolToValidate);

@end

@implementation JRTFormSwitchTableViewCell

@synthesize name = _name;

#pragma mark - styles

- (void)setDefaultStyle {
    self.label.textColor = [UIColor darkGrayColor];
    self.label.hidden = YES;
    self.label.text = self.name;
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage {
    self.label.textColor = [UIColor redColor];
    self.label.hidden = NO;
    self.label.text = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
}

- (void)updateStyle {
    if (!self.isValid) {
        [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.pickerSwitch.isOn)];
    }
    else {
        [self setDefaultStyle];
    }
}

#pragma mark - Actions

- (IBAction)changeValue:(id)sender {
    [self updateStyle];
}

#pragma mark - Getters

- (BOOL)isValid {
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock) {
        NSString *errorMessage = self.errorMessageInValidationBlock(self.pickerSwitch.isOn);
        if (errorMessage && ![errorMessage isEqualToString:@""]) {
            valid = NO;
        }
    }
    return valid;
}

- (BOOL)on {
    return self.pickerSwitch.isOn;
}

#pragma mark - Setter

- (void)setOn:(BOOL)on {
    [self.pickerSwitch setOn:on animated:YES];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.label.text = name;
    self.nameLabel.text = name;
}

@end
