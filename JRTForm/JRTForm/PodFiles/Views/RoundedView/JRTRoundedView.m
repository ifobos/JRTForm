//
//  JRTRoundedView.m
//
//
//  Created by Juan Garcia on 16/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTRoundedView.h"

@implementation JRTRoundedView


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
