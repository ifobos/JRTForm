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


#import "JRTFormArrayValidations.h"

@implementation JRTFormArrayValidations

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
