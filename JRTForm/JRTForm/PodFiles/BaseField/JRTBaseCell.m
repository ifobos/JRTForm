//
//  JRTBaseCell.m
//  
//
//  Created by Juan Garcia on 13/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTBaseCell.h"
#import "JRTFormTableView.h"

@interface JRTBaseCell ()

@end
@implementation JRTBaseCell

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
