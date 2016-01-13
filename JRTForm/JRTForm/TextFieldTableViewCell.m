//
//  TextFieldTableViewCell.m
//  
//
//  Created by Juan Garcia on 9/7/15.
//  Copyright (c) 2015 Juan Garcia. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@interface TextFieldTableViewCell ()
@property (weak, nonatomic) IBOutlet UITextField    *textField;
@property (weak, nonatomic) IBOutlet UILabel        *label;

@end

@implementation TextFieldTableViewCell


- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    __block TextFieldTableViewCell *blocksafeSelf = self;
    [self setDidBeginEditing:^(UITextField *textField) {
        [blocksafeSelf setHighlightedStyle:YES];
    }];
    [self setDidEndEditing:^(UITextField *textField) {
        [blocksafeSelf setHighlightedStyle:NO];
    }];
    [self setHighlightedStyle:NO];
}


- (void)setHighlightedStyle:(BOOL)highlighted
{
    if (highlighted)
    {
        self.textField.backgroundColor  = [UIColor lightGrayColor];
    }
    else
    {
        self.textField.backgroundColor  = [UIColor whiteColor];
    }
}

- (void)setInitialLabelText:(NSString*)text
{
    self.label.text     = text;
    self.label.hidden   = NO;
}

@end
