//
//  JTRArrayValidations.h
//
//
//  Created by Juan Garcia on 15/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import Foundation;
@interface JRTArrayValidations : NSObject

@property (nonatomic,readonly)NSString* (^required)     (NSArray *array);
@property (nonatomic,readonly)NSString* (^maxLength)    (NSArray *array, NSUInteger maxlength);
@property (nonatomic,readonly)NSString* (^minLength)    (NSArray *array, NSUInteger minlength);
@property (nonatomic,readonly)NSString* (^exactLength)  (NSArray *array, NSUInteger exactlength);

@end
