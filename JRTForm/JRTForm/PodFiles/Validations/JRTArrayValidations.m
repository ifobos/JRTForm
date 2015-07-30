//
//  JTRArrayValidations.m
//
//
//  Created by Juan Garcia on 15/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTArrayValidations.h"

@implementation JRTArrayValidations

#pragma mark - Getters

- (NSString* (^)(NSArray *array))required
{
    return ^NSString*(NSArray *array)
    {
        if(!array || [array count] < 1) return @"is required.";
        else return nil;
    };
}

- (NSString *(^)(NSArray *array, NSUInteger maxlength))maxLength
{
    return ^NSString*(NSArray *array, NSUInteger maxlength)
    {
        if ([array count] > maxlength && [array count] > 0) return [NSString stringWithFormat:@"can not be more than %lu elements.", (unsigned long)maxlength];
        else return nil;
    };
}

- (NSString *(^)(NSArray *array, NSUInteger minLength))minLength
{
    return ^NSString*(NSArray *array, NSUInteger minLength)
    {
        if ([array count] < minLength && [array count] > 0) return [NSString stringWithFormat:@"can not be less than %lu elements.", (unsigned long)minLength];
        else return nil;
    };
}

- (NSString *(^)(NSArray *array, NSUInteger exactLength))exactLength
{
    return ^NSString*(NSArray *array, NSUInteger exactLength)
    {
        if ([array count] != exactLength && [array count] > 0) return [NSString stringWithFormat:@"must be %lu elements.", (unsigned long)exactLength];
        else return nil;
    };
}

@end
