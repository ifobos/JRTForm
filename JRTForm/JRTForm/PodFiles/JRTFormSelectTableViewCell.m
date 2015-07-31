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


#import "JRTFormSelectTableViewCell.h"
#import "JRTFormOptionsTableViewController.h"

NSString * const kJRTFormFieldSelectTableViewCell = @"JRTFormSelectTableViewCell";

@interface JRTFormSelectTableViewCell ()<JRTOptionsTableViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UILabel *textSelectedLabel;

@property (nonatomic, strong)   NSArray *selectedOptions;
@property (nonatomic, copy)     NSString * (^errorMessageInValidationBlock)   (NSArray *arrayToValidate);

@end

@implementation JRTFormSelectTableViewCell

@synthesize name = _name;

#pragma mark - styles

- (void)setDefaultStyle
{
    self.label.textColor            = [UIColor darkGrayColor];
    self.label.hidden               = NO;
    self.label.text                 = self.name;
    self.placeholderLabel.hidden    = YES;
    self.textSelectedLabel.hidden   = NO;
}

- (void)setEmptyStyle
{
    self.label.textColor            = [UIColor darkGrayColor];
    self.label.hidden               = YES;
    self.label.text                 = self.name;
    self.placeholderLabel.hidden    = NO;
    self.textSelectedLabel.hidden   = YES;
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage
{
    self.label.textColor            = [UIColor redColor];
    self.label.hidden               = NO;
    self.label.text                 = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
    self.textSelectedLabel.hidden   = ([self.textSelectedLabel.text length] == 0);
    self.placeholderLabel.hidden    = !self.textSelectedLabel.hidden;
}

- (void)updateStyle
{
    if (!self.isValid) [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.selectedIndexes)];
    else if (self.selectedOptions && [self.selectedOptions count] > 0) [self setDefaultStyle];
    else [self setEmptyStyle];
}

#pragma mark - Getters

- (BOOL)isValid
{
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock)
    {
        NSString * errorMessage = self.errorMessageInValidationBlock(self.selectedOptions);
        if (errorMessage && ![errorMessage isEqualToString:@""]) valid = NO;
    }
    return valid;
}

-(NSNumber *)selectedIndex
{
    if (self.singleSelection)
    {
        return [self.selectedIndexes firstObject];
    }
    else
    {
        @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                           reason:[NSString stringWithFormat:@"%@ invalid, you must assign the singleSelection property to YES", NSStringFromSelector(_cmd)]
                                         userInfo:nil];
        return nil;
    }
}

#pragma mark - Setters

-(void)setOptions:(NSArray *)options
{
    for (id option in options)
        if (![option isKindOfClass:[NSString class]])
            @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                               reason:[NSString stringWithFormat:@"%@ must contain only objects of type NSString", NSStringFromSelector(_cmd)]
                                             userInfo:nil];
    _options = options;
}

- (void)setName:(NSString *)name
{
    _name                       = name;
    self.placeholderLabel.text  = name;
    self.label.text             = name;
}

-(void)setSelectedOptions:(NSArray *)selectedOptions
{
    _selectedOptions        = selectedOptions;
    if ([selectedOptions count] <= 1)
    {
        self.textSelectedLabel.text = [selectedOptions firstObject];
    }
    else
    {
        NSMutableString *text   = [NSMutableString new];
        for (int i = 0 ; i < [selectedOptions count]; i++)
        {
            NSString *option =  [selectedOptions objectAtIndex:i];
            [text appendString:option];
            if (i < [selectedOptions count]-1) [text appendString:@", "];
        }
        self.textSelectedLabel.text = [text stringByAppendingString:@"."];
    }
    
    [self updateStyle];
}

-(void)setSelectedIndexes:(NSArray *)selectedIndexes
{
    _selectedIndexes                = selectedIndexes;
    NSMutableArray *selectedValues  = [NSMutableArray new];
    for (NSNumber *index in selectedIndexes) [selectedValues addObject:[self.options objectAtIndex:index.intValue]];
    self.selectedOptions            = selectedValues;
    [self updateStyle];
}

#pragma mark - Options

- (void)displayOptions
{
    JRTFormOptionsTableViewController *optionsViewController = [JRTFormOptionsTableViewController new];
    optionsViewController.asignatedDelegate = self;
    optionsViewController.singleSelection   = self.singleSelection;
    [optionsViewController show];
}

#pragma mark - Actions

- (IBAction)touchUpInside:(id)sender
{
    [self displayOptions];
}

@end