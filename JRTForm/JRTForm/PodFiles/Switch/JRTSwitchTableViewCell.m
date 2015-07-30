//
//  JRTSwitchTableViewCell.m
//  
//
//  Created by Juan Garcia on 9/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTSwitchTableViewCell.h"

NSString * const JRTFormFieldSwitchTableViewCell = @"JRTSwitchTableViewCell";

@interface JRTSwitchTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UISwitch *pickerSwitch;

@property (nonatomic, copy)     NSString * (^errorMessageInValidationBlock)   (BOOL boolToValidate);
@end

@implementation JRTSwitchTableViewCell

@synthesize name = _name;

#pragma mark - styles

- (void)setDefaultStyle
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
    if (!self.isValid) [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.pickerSwitch.isOn)];
    else [self setDefaultStyle];
}

#pragma mark - Actions

- (IBAction)changeValue:(id)sender
{
    [self updateStyle];
}

#pragma mark - Getters

- (BOOL)isValid
{
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock)
    {
        NSString * errorMessage = self.errorMessageInValidationBlock(self.pickerSwitch.isOn);
        if (errorMessage && ![errorMessage isEqualToString:@""]) valid = NO;
    }
    return valid;
}

- (BOOL)on
{
    return self.pickerSwitch.isOn;
}

#pragma mark - Setter

- (void)setOn:(BOOL)on
{
    [self.pickerSwitch setOn:on animated:YES];
}

- (void)setName:(NSString *)name
{
    _name               = name;
    self.label.text     = name;
    self.nameLabel.text = name;
}

@end
