//
//  JRTMultiselectTableViewCell.m
//  
//
//  Created by Juan Garcia on 9/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTSelectTableViewCell.h"
#import "JRTOptionsTableViewController.h"

NSString * const JRTFormFieldSelectTableViewCell = @"JRTSelectTableViewCell";

@interface JRTSelectTableViewCell ()<JRTOptionsTableViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UILabel *textSelectedLabel;

@property (nonatomic, strong)   NSArray *selectedOptions;
@property (nonatomic, copy)     NSString * (^errorMessageInValidationBlock)   (NSArray *arrayToValidate);

@end

@implementation JRTSelectTableViewCell

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
    JRTOptionsTableViewController *optionsViewController = [JRTOptionsTableViewController new];
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