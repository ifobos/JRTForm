//
//  JRTSubmitButtonTableViewCell.m
//  
//
//  Created by Juan Garcia on 21/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTSubmitButtonTableViewCell.h"

NSString * const JRTFormFieldSubmitButtonTableViewCell = @"JRTSubmitButtonTableViewCell";

@interface JRTSubmitButtonTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) BOOL success;
@property (nonatomic, copy) void (^submitBlock) (NSArray *fieldCells);
@end

@implementation JRTSubmitButtonTableViewCell


@synthesize name = _name;

- (void)setName:(NSString *)name
{
    _name                       = name;
    self.label.text             = name;
    [self.button setTitle:name forState:UIControlStateNormal];
}


- (void)setDefaultStyle
{
    self.label.textColor    = [UIColor darkGrayColor];
    self.label.text         = self.name;
    self.label.hidden       = YES;
}

- (void)setErrortStyle
{
    self.label.textColor    = [UIColor redColor];
    self.label.text         = self.errorMessage;
    self.label.hidden       = NO;
}

- (void)updateStyle
{
    if (!self.isValid)      [self setErrortStyle];
    else                    [self setDefaultStyle];
        
}

- (BOOL)isValid
{
    BOOL valid = YES;
    if (self.fields)
    {
        for (JRTBaseCell *targetCell in self.fields)
        {
            if (!targetCell.isValid)
            {
                valid = NO;
                [targetCell updateStyle];
            }
        }
    }
    return  valid;
}


- (IBAction)submit:(id)sender
{
    if (self.isValid)
    {
        [self setDefaultStyle];
        self.submitBlock(self.fields);
    }
    else
    {
        [self setErrortStyle];
    }
}

- (void)setButtonBackgroundColor:(UIColor *)color
{
    [self.button setBackgroundColor:color];
}

- (void)setButtonTittleColor:(UIColor *)color
{
    [self.button setTitleColor:color forState:UIControlStateNormal];
}

@end
