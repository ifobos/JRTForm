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
/*!
 Base class which depend on the different available cells.
 */
@interface JRTFormBaseCell : UITableViewCell

/*!
 Boolean property read-only indicating whether the contents of the cell is 
 valid according to block validation provided by default does not have.
 validation rules and returns YES.
 */
@property (nonatomic, readonly) BOOL isValid;

/*!
 Property that contains the name of the field representing the cell.
 */
@property (nonatomic, strong) NSString *name;

/*!
 Method which seeks UITableView in which the cell is contained.
 
 @return Table view in which the cell is contained.
 */
- (UITableView *)superTableView;

/*!
 Method which according to the validity of the cell contents changes the 
 appearance of the cell to make it consistent with the content.
 */
- (void)updateStyle;

@end
