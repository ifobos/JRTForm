//
//  JRTStringValidations.m
//
//
//  Created by Juan Garcia on 8/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTStringValidations.h"

@implementation JRTStringValidations

#pragma mark - helpers

- (BOOL)testString:(NSString *)string WithReg:(NSString *)regularExpression
{
    if (string.length > 0)
    {
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularExpression];
    return [test evaluateWithObject:string];
    }
    else return YES;
}

#pragma mark - getters

- (NSString* (^)(NSString *string))required
{
    return ^NSString*(NSString *string)
    {
        if(string.length < 1) return @"is required.";
        else return nil;
    };
}

- (NSString *(^)(NSString *string, NSUInteger maxlength))maxLength
{
    return ^NSString*(NSString *string, NSUInteger maxlength)
    {
        if ([string length] > maxlength && string.length > 0) return [NSString stringWithFormat:@"can not be more than %lu characters.", (unsigned long)maxlength];
        else return nil;
    };
}

- (NSString *(^)(NSString *string, NSUInteger minLength))minLength
{
    return ^NSString*(NSString *string ,NSUInteger minLength)
    {
        if ([string length] < minLength && string.length > 0) return [NSString stringWithFormat:@"can not be less than %lu characters.", (unsigned long)minLength];
        else return nil;
    };
}

- (NSString *(^)(NSString *string, NSUInteger exactLength))exactLength
{
    return ^NSString*(NSString *string, NSUInteger exactLength)
    {
        if ([string length] != exactLength && string.length > 0) return [NSString stringWithFormat:@"must be %lu characters.", (unsigned long)exactLength];
        else return nil;
    };
}

- (NSString *(^)(NSString *string))alpha
{
    return ^NSString*(NSString *string)
    {
        if (![self testString:string WithReg:@"[a-zA-Z]+"]) return @"must be only alphabetic characters.";
        else return nil;
    };
}

- (NSString *(^)(NSString *string))alphaSpace
{
    return ^NSString*(NSString *string)
    {
        if (![self testString:string WithReg:@"[a-zA-Z\\s]+"]) return @"must be only alphabetic characters.";
        else return nil;
    };
}

- (NSString *(^)(NSString *string))numeric
{
    return ^NSString*(NSString *string)
    {
        if (![self testString:string WithReg:@"[0-9]+"]) return @"must be only numeric characters.";
        else return nil;
    };
}

- (NSString *(^)(NSString *string))decimal
{
    return ^NSString*(NSString *string)
    {
        if (![self testString:string WithReg:@"[0-9]+(\\.[0-9])?"]) return @"must be only numeric characters.";
        else return nil;
    };
}

- (NSString *(^)(NSString *string))twoDecimals
{
    return ^NSString*(NSString *string)
    {
        if (![self testString:string WithReg:@"[0-9]+(\\.[0-9][0-9])?"]) return @"must be only num 2 decimals.";
        else return nil;
    };
}

- (NSString *(^)(NSString *string))eMail
{
    return ^NSString*(NSString *string)
    {
        if (![self testString:string WithReg:@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"]) return @"must be a complete email.";
        else return nil;
    };
}

@end
