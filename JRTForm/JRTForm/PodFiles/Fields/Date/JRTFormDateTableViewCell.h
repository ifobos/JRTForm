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

@import UIKit;
#import "JRTFormBaseCell.h"

/*!
 Class name and the nib of the cell.
 */
extern NSString *const kJRTFormFieldDateTableViewCell;

/*!
 Cell having a form field to catch a date.
 */
@interface JRTFormDateTableViewCell : JRTFormBaseCell

/*!
 Property that contains the date captured
 */
@property (nonatomic, strong) NSDate *date;

/*!
 Property that contains the date formatter
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

/*!
 Receiving the block method validation for date captured.
 
 @param errorMessageInValidationBlock block must validate the date received and
                                      returns an error message if the received 
                                      date is valid returns nil.
 */
- (void)setErrorMessageInValidationBlock:(NSString *(^)(NSDate *dateToValidate))errorMessageInValidationBlock;


/*!
 Receives color for placeholder
 
 @param color placeholder color
 */
- (void)setPlaceholderColor:(UIColor *)color;

/*!
 Method that sets the default appearance with valid data.
 */
- (void)setDefaultStyle;

/*!
 Method that sets the empty appearance.
 */
- (void)setEmptyStyle;

/*!
 Method that sets the error appearance.
 
 @param errorMessage String which is concatenated to the name of the field and 
                     explaining the error happened.
 */
- (void)setErrorStyleWithMessage:(NSString *)errorMessage;

@end
