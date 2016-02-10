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


#import "JRTFormSubmitButtonTableViewCell.h"

NSString *const kJRTFormFieldSubmitButtonTableViewCell = @"JRTFormSubmitButtonTableViewCell";

@interface JRTFormSubmitButtonTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) BOOL success;
@property (nonatomic, copy) void (^submitBlock) (NSArray *fieldCells);

@end

@implementation JRTFormSubmitButtonTableViewCell


@synthesize name = _name;

- (void)setName:(NSString *)name {
    _name = name;
    self.label.text = name;
    [self.button setTitle:name forState:UIControlStateNormal];
}

- (void)setDefaultStyle {
    self.label.textColor = [UIColor darkGrayColor];
    self.label.text = self.name;
    self.label.hidden = YES;
}

- (void)setErrortStyle {
    self.label.textColor = [UIColor redColor];
    self.label.text = self.errorMessage;
    self.label.hidden = NO;
}

- (void)updateStyle {
    if (!self.isValid) {
        [self setErrortStyle];
    }
    else {
        [self setDefaultStyle];
    }
}

- (BOOL)isValid {
    BOOL valid = YES;
    if (self.fields) {
        for (JRTFormBaseCell *targetCell in self.fields) {
            if (!targetCell.isValid) {
                valid = NO;
                [targetCell updateStyle];
            }
        }
    }
    return valid;
}

- (IBAction)submit:(id)sender {
    if (self.isValid) {
        [self setDefaultStyle];
        self.submitBlock(self.fields);
    }
    else {
        [self setErrortStyle];
    }
}

- (void)setButtonBackgroundColor:(UIColor *)color {
    [self.button setBackgroundColor:color];
}

- (void)setButtonTittleColor:(UIColor *)color {
    [self.button setTitleColor:color forState:UIControlStateNormal];
}

@end
