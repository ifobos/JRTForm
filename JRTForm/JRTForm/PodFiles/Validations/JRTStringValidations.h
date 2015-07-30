//
//  JRTStringValidations.h
//  
//
//  Created by Juan Garcia on 8/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

@import Foundation;
@interface JRTStringValidations : NSObject

@property (nonatomic,readonly)NSString* (^required)     (NSString *string);
@property (nonatomic,readonly)NSString* (^maxLength)    (NSString *string, NSUInteger maxlength);
@property (nonatomic,readonly)NSString* (^minLength)    (NSString *string, NSUInteger minlength);
@property (nonatomic,readonly)NSString* (^exactLength)  (NSString *string, NSUInteger exactlength);
@property (nonatomic,readonly)NSString* (^alpha)        (NSString *string);
@property (nonatomic,readonly)NSString* (^alphaSpace)   (NSString *string);
@property (nonatomic,readonly)NSString* (^numeric)      (NSString *string);
@property (nonatomic,readonly)NSString* (^decimal)      (NSString *string);
@property (nonatomic,readonly)NSString* (^twoDecimals)  (NSString *string);
@property (nonatomic,readonly)NSString* (^eMail)        (NSString *string);


//greater_than
//less_than
@end
