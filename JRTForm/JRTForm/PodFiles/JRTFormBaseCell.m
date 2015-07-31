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


#import "JRTFormBaseCell.h"
#import "JRTFormTableView.h"

@interface JRTFormBaseCell ()

@end
@implementation JRTFormBaseCell

-(void)didMoveToSuperview
{
    UITableView *tableView = [self superTableView];
    if (tableView && ![tableView isKindOfClass:[JRTFormTableView class]])
    {
        @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                           reason:[NSString stringWithFormat:@"TableView must be of class JRTFormTableView"]
                                         userInfo:nil];
    }
}

-(UITableView *)superTableView
{
    id view = [self superview];
    while (view && ![view isKindOfClass:[UITableView class]])
    {
     view = [view superview];
    }
    return  (UITableView *)view;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@, this cell should not be reused. ", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
}




- (void)setName:(NSString *)name
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@ should be implemented in the sub class", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
}

- (BOOL)isValid
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@ should be implemented in the sub class", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
}

-(void)updateStyle
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@ should be implemented in the sub class", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
}

@end
