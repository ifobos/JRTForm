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

#import "JRTFormDateTableViewCell.h"
#import "JRTFormDatePickerViewController.h"

NSString *const kJRTFormFieldDateTableViewCell = @"JRTFormDateTableViewCell";

@interface JRTFormDateTableViewCell ()<JRTDatePickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UILabel *textSelectedLabel;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic) BOOL hideableLabel;

@property (nonatomic, copy) NSString * (^errorMessageInValidationBlock) (NSDate *dateToValidate);

@end

@implementation JRTFormDateTableViewCell

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
    self.textSelectedLabel.hidden = NO;
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
    self.textSelectedLabel.hidden = YES;
    if (self.hideableLabel) {
        self.label.hidden = YES;
    }
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage {
    if (self.labelColor) {
        self.label.textColor = [UIColor redColor];
    }
    self.label.text = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
    self.textSelectedLabel.hidden = ([self.textSelectedLabel.text length] == 0);
    self.placeholderLabel.hidden = !self.textSelectedLabel.hidden;
    if (self.hideableLabel) {
        self.label.hidden = NO;
    }
}

- (void)updateStyle {
    if (!self.isValid) {
        [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.date)];
    }
    else if (self.date) {
        [self setDefaultStyle];
    }
    else {
        [self setEmptyStyle];
    }
}

#pragma mark - Getters

- (BOOL)isValid {
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock) {
        NSString *errorMessage = self.errorMessageInValidationBlock(self.date);
        if (errorMessage && ![errorMessage isEqualToString:@""]) {
            valid = NO;
        }
    }
    return valid;
}

#pragma mark - Setters

- (void)setName:(NSString *)name {
    _name = name;
    self.placeholderLabel.text = name;
    self.label.text = name;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
    self.textSelectedLabel.text = [dateFormatter stringFromDate:date];
    [self updateStyle];
}

#pragma mark - DatePicker

- (void)displayDatePicker {
    JRTFormDatePickerViewController *datePickerViewController = [JRTFormDatePickerViewController new];
    datePickerViewController.delegate = self;
    datePickerViewController.title = self.name;
    [datePickerViewController show];
}

#pragma mark - Actions

- (IBAction)touchUpInside:(id)sender {
    [self displayDatePicker];
}

@end
