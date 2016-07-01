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


#import "JRTFormRoundedView.h"

@implementation JRTFormRoundedView


-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self applyStyle];
}


- (void)applyStyle
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = self.cornerRadius;
    self.layer.borderColor   = self.borderColor.CGColor;
    self.layer.borderWidth   = self.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius != cornerRadius)
    {
        _cornerRadius = cornerRadius;
        if ([self superview]) [self applyStyle];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (_borderWidth != borderWidth)
    {
        _borderWidth = borderWidth;
        if ([self superview]) [self applyStyle];
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (!CGColorEqualToColor(_borderColor.CGColor, borderColor.CGColor))
    {
        _borderColor = borderColor;
        if ([self superview]) [self applyStyle];
    }
}

@end
