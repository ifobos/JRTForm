//
//  JRTRoundedButton.m
//  
//
//  Created by Juan Garcia on 21/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTRoundedButton.h"

@implementation JRTRoundedButton

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self applyCornerRadius];
}

- (void)applyCornerRadius
{
    self.layer.cornerRadius     = self.cornerRadius;
    self.layer.masksToBounds    = YES;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    if ([self superview]) [self applyCornerRadius];
}

@end
