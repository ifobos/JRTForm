//
//  JRTLoginTableViewController.m
//  JertiObjectiveCDemo
//
//  Created by Juan Garcia on 12/5/15.
//  Copyright (c) 2015 Jerti. All rights reserved.
//

#import "JRTFormViewController.h"
#import "JRTFormFieldCells.h"
#import "JRTFormValidationsBlocks.h"
#import "JRTFormTableView.h"


NSString * const ktextField                     = @"textField";
NSString * const ksecureTextField               = @"secureTextField";
NSString * const ktextViewField                 = @"textViewField";
NSString * const kselectOptionField             = @"selectOptionField";
NSString * const kselectMultipleOptionField     = @"selectMultipleOptionField";
NSString * const kswitchField                   = @"switchField";
NSString * const kdateField                     = @"dateField";
NSString * const kmapField                      = @"mapField";

@interface JRTFormViewController ()
@property (nonatomic, strong) JRTFormTextFieldTableViewCell     *textField;
@property (nonatomic, strong) JRTFormTextFieldTableViewCell     *secureTextField;
@property (nonatomic, strong) JRTFormTextViewTableViewCell      *textViewField;
@property (nonatomic, strong) JRTFormSelectTableViewCell        *selectOptionField;
@property (nonatomic, strong) JRTFormSelectTableViewCell        *selectMultipleOptionField;
@property (nonatomic, strong) JRTFormSwitchTableViewCell        *switchField;
@property (nonatomic, strong) JRTFormDateTableViewCell          *dateField;
@property (nonatomic, strong) JRTFormMapTableViewCell           *mapField;
@property (nonatomic, strong) JRTFormSubmitButtonTableViewCell  *submitButton;

@property (nonatomic, strong)JRTFormStringValidations * stringValidationHelper;
@property (nonatomic, strong)JRTFormArrayValidations  * arrayValidationHelper;

@property (nonatomic, readonly)JRTFormTableView *formTableView;
@end

@implementation JRTFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Form";
}

#pragma mark - Properties

- (JRTFormStringValidations *)stringValidationHelper
{
    if (!_stringValidationHelper) _stringValidationHelper = [JRTFormStringValidations new];
    return _stringValidationHelper;
}

- (JRTFormArrayValidations *)arrayValidationHelper
{
    if (!_arrayValidationHelper) _arrayValidationHelper = [JRTFormArrayValidations new];
    return _arrayValidationHelper;
}


#pragma mark - Getters
- (JRTFormTableView *)formTableView
{
    return (JRTFormTableView *)self.tableView;
}


- (JRTFormTextFieldTableViewCell *)textField
{
    if (!_textField)
    {
        _textField                      = [self.formTableView formTextFieldTableViewCellWithName:ktextField];
        [_textField setReturnKeyType:UIReturnKeyNext];
        __block JRTFormViewController *blocksafeSelf = self;
        [_textField setShouldReturn:^BOOL(UITextField *textField)
        {
            [blocksafeSelf.secureTextField fieldBecomeFirstResponder];
            return NO;
        }];
        [_textField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate)
        {
            NSString *errorMessage          = nil;
            if (!errorMessage) errorMessage = self.stringValidationHelper.required(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.alpha(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.maxLength(stringToValidate,8);
            if (!errorMessage) errorMessage = self.stringValidationHelper.minLength(stringToValidate,3);
            return errorMessage;
        }];
    }
    return _textField;
}

- (JRTFormTextFieldTableViewCell *)secureTextField
{
    if (!_secureTextField)
    {
        _secureTextField                = [self.formTableView formTextFieldTableViewCellWithName:ksecureTextField];
        [_secureTextField setSecureTextEntry:YES];
        [_secureTextField setReturnKeyType:UIReturnKeyNext];
        __block JRTFormViewController *blocksafeSelf = self;
        [_secureTextField setShouldReturn:^BOOL(UITextField *textField)
         {
             [blocksafeSelf.textViewField fieldBecomeFirstResponder];
             return NO;
         }];
        [_secureTextField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate)
        {
            NSString *errorMessage          = nil;
            if (!errorMessage) errorMessage = self.stringValidationHelper.required(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.minLength(stringToValidate,3);
            return errorMessage;
        }];
    }
    return _secureTextField;
}

- (JRTFormTextViewTableViewCell *)textViewField
{
    if (!_textViewField)
    {
        _textViewField                  = [self.formTableView formTextViewTableViewCellWithName:ktextViewField];
        [_textViewField setKeyboardType:UIKeyboardTypeEmailAddress];
        [_textViewField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate) {
        NSString *errorMessage          = nil;
        if (!errorMessage) errorMessage = self.stringValidationHelper.required(stringToValidate);
        if (!errorMessage) errorMessage = self.stringValidationHelper.alphaSpace(stringToValidate);
        if (!errorMessage) errorMessage = self.stringValidationHelper.minLength(stringToValidate,3);
            return errorMessage;
        }];
    }
    return _textViewField;
}


- (JRTFormSelectTableViewCell *)selectOptionField
{
    if (!_selectOptionField)
    {
        _selectOptionField              = [self.formTableView formSelectTableViewCellWithName:kselectOptionField];
        _selectOptionField.options      = @[@"Rojo", @"Azul", @"Verde", @"Naranja", @"Negro", @"Blanco", @"Gris"];
        [_selectOptionField setSingleSelection:YES];
        [_selectOptionField setErrorMessageInValidationBlock:^NSString *(NSArray *arrayToValidate) {
        NSString *errorMessage          = nil;
        if (!errorMessage) errorMessage = self.arrayValidationHelper.required(arrayToValidate);
            return errorMessage;
        }];
    }
    return _selectOptionField;
}

- (JRTFormSelectTableViewCell *)selectMultipleOptionField
{
    if (!_selectMultipleOptionField)
    {
        _selectMultipleOptionField         = [self.formTableView formSelectTableViewCellWithName:kselectMultipleOptionField];
        _selectMultipleOptionField.options = @[@"Rojo", @"Azul", @"Verde", @"Naranja", @"Negro", @"Blanco", @"Gris"];
        [_selectMultipleOptionField setSingleSelection:NO];
        [_selectMultipleOptionField setErrorMessageInValidationBlock:^NSString *(NSArray *arrayToValidate) {
        NSString *errorMessage             = nil;
        if (!errorMessage) errorMessage    = self.arrayValidationHelper.required(arrayToValidate);
        if (!errorMessage) errorMessage    = self.arrayValidationHelper.minLength(arrayToValidate, 2);
        if (!errorMessage) errorMessage    = self.arrayValidationHelper.maxLength(arrayToValidate, 4);
            return errorMessage;
        }];
    }
    return _selectMultipleOptionField;
}

- (JRTFormSwitchTableViewCell *)switchField
{
    if (!_switchField)
    {
        _switchField = [self.formTableView formSwitchTableViewCellWithName:kswitchField];
    }
    return _switchField;
}

- (JRTFormDateTableViewCell *)dateField
{
    if (!_dateField)
    {
        _dateField = [self.formTableView formDateTableViewCellWithName:kdateField];
    }
    return _dateField;
}

- (JRTFormMapTableViewCell *)mapField
{
    if (!_mapField)
    {
        _mapField = [self.formTableView formMapTableViewCellWithName:kmapField];
        [_mapField setErrorMessageInValidationBlock:^NSString *(CLLocationCoordinate2D locationCoordinate) {
            if (locationCoordinate.latitude == 0 && locationCoordinate.longitude == 0)
            {
                return @"is required";
            }
            else return nil;
        }];

    }
    return _mapField;
}

- (JRTFormSubmitButtonTableViewCell *)submitButton
{
    if (!_submitButton)
    {
        static NSString *kSubmit = @"Submit";
        _submitButton = [self.formTableView formSubmitButtonTableViewCellWithName:kSubmit];
        [_submitButton setFields:(NSMutableArray *)@[self.textField, self.secureTextField, self.textViewField, self.selectOptionField, self.selectMultipleOptionField, self.mapField]];
        __block JRTFormViewController *blockSelf = self;
        [_submitButton setSubmitBlock:^(NSArray *fieldCells) {
            NSLog(@"%@: %@",ktextField,                 blockSelf.textField.text);
            NSLog(@"%@: %@",ksecureTextField,           blockSelf.secureTextField.text);
            NSLog(@"%@: %@",ktextViewField,             blockSelf.textViewField.text);
            NSLog(@"%@: %@",kselectOptionField,         blockSelf.selectOptionField.selectedIndex);
            NSLog(@"%@: %@",kselectMultipleOptionField, blockSelf.selectMultipleOptionField.selectedIndexes);
            NSLog(@"testMap: %f, %f", blockSelf.mapField.coordinate.longitude, blockSelf.mapField.coordinate.latitude);

            //TODO: JC - agregar una alerta
        }];
        
    }
    return _submitButton;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
         if(indexPath.row == 0)     return self.textField;
    else if(indexPath.row == 1)     return self.secureTextField;
    else if(indexPath.row == 2)     return self.textViewField;
    else if(indexPath.row == 3)     return self.selectOptionField;
    else if(indexPath.row == 4)     return self.selectMultipleOptionField;
    else if(indexPath.row == 5)     return self.switchField;
    else if(indexPath.row == 6)     return self.dateField;
    else if(indexPath.row == 7)     return self.mapField;
    else
    {
        return self.submitButton;
    }

}

@end
