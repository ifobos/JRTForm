//
//  JRTRoundedImageView.m
//  Trainer
//
//  Created by Juan Garcia on 16/6/15.
//  Copyright (c) 2015 Jerti. All rights reserved.
//

#import "JRTRoundedImageView.h"

@implementation JRTRoundedImageView


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
