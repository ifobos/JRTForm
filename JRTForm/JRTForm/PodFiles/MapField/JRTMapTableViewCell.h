//
//  JRTMapTableViewCell.h
//  JertiObjectiveCDemo
//
//  Created by Juan Garcia on 21/6/15.
//  Copyright (c) 2015 Jerti. All rights reserved.
//

@import UIKit;
@import MapKit;

#import "JRTBaseCell.h"
extern NSString * const JRTFormFieldMapTableViewCell;

@interface JRTMapTableViewCell : JRTBaseCell

@property (nonatomic)CLLocationCoordinate2D coordinate;
- (void)setErrorMessageInValidationBlock:   (NSString *(^)(CLLocationCoordinate2D locationCoordinate))errorMessageInValidationBlock;

- (void)setDefaultStyle;
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;
@end
