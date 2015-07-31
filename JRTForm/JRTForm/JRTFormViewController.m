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


NSString * const ktextField                     = @"textField";
NSString * const ksecureTextField               = @"secureTextField";
NSString * const ktextViewField                 = @"textViewField";
NSString * const kselectOptionField             = @"selectOptionField";
NSString * const kselectMultipleOptionField     = @"selectMultipleOptionField";
NSString * const kswitchField                   = @"switchField";
NSString * const kmapField                      = @"mapField";

@interface JRTFormViewController ()
@property (nonatomic, strong) JRTFormTextFieldTableViewCell     *textField;
@property (nonatomic, strong) JRTFormTextFieldTableViewCell     *secureTextField;
@property (nonatomic, strong) JRTFormTextViewTableViewCell      *textViewField;
@property (nonatomic, strong) JRTFormSelectTableViewCell        *selectOptionField;
@property (nonatomic, strong) JRTFormSelectTableViewCell        *selectMultipleOptionField;
@property (nonatomic, strong) JRTFormSwitchTableViewCell        *switchField;
@property (nonatomic, strong) JRTFormMapTableViewCell           *mapField;
@property (nonatomic, strong) JRTFormSubmitButtonTableViewCell  *submitButton;

@property (nonatomic, strong)JRTFormStringValidations * stringValidationHelper;
@property (nonatomic, strong)JRTFormArrayValidations  * arrayValidationHelper;

@end

@implementation JRTFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Form";
}

#pragma mark - Properties

-(JRTFormStringValidations *)stringValidationHelper
{
    if (!_stringValidationHelper) _stringValidationHelper = [JRTFormStringValidations new];
    return _stringValidationHelper;
}

-(JRTFormArrayValidations *)arrayValidationHelper
{
    if (!_arrayValidationHelper) _arrayValidationHelper = [JRTFormArrayValidations new];
    return _arrayValidationHelper;
}


#pragma mark - Getters

-(JRTFormTextFieldTableViewCell *)textField
{
    if (!_textField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldTextFieldTableViewCell bundle:nil] forCellReuseIdentifier:ktextField];
        _textField = [self.tableView dequeueReusableCellWithIdentifier:ktextField];
        [_textField setName:ktextField];
        [_textField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate) {
            NSString *errorMessage = nil;
            if (!errorMessage) errorMessage = self.stringValidationHelper.required(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.alpha(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.maxLength(stringToValidate,8);
            if (!errorMessage) errorMessage = self.stringValidationHelper.minLength(stringToValidate,3);
            return errorMessage;
        }];
    }
    return _textField;
}

-(JRTFormTextFieldTableViewCell *)secureTextField
{
    if (!_secureTextField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldTextFieldTableViewCell bundle:nil] forCellReuseIdentifier:ksecureTextField];
        _secureTextField = [self.tableView dequeueReusableCellWithIdentifier:ksecureTextField];
        [_secureTextField setName:ksecureTextField];
        [_secureTextField setSecureTextEntry:YES];
        [_secureTextField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate) {
            NSString *errorMessage = nil;
            if (!errorMessage) errorMessage = self.stringValidationHelper.required(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.minLength(stringToValidate,3);
            return errorMessage;
        }];
    }
    return _secureTextField;
}

-(JRTFormTextViewTableViewCell *)textViewField
{
    if (!_textViewField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldTextViewTableViewCell bundle:nil] forCellReuseIdentifier:ktextViewField];
        _textViewField = [self.tableView dequeueReusableCellWithIdentifier:ktextViewField];
        [_textViewField setName:ktextViewField];
        [_textViewField setKeyboardType:UIKeyboardTypeEmailAddress];
        [_textViewField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate) {
            NSString *errorMessage = nil;
            if (!errorMessage) errorMessage = self.stringValidationHelper.required(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.alphaSpace(stringToValidate);
            if (!errorMessage) errorMessage = self.stringValidationHelper.minLength(stringToValidate,3);
            return errorMessage;
        }];
    }
    return _textViewField;
}


-(JRTFormSelectTableViewCell *)selectOptionField
{
    if (!_selectOptionField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldSelectTableViewCell bundle:nil] forCellReuseIdentifier:kselectOptionField];
        _selectOptionField = [self.tableView dequeueReusableCellWithIdentifier:kselectOptionField];
        _selectOptionField.options = @[@"Rojo", @"Azul", @"Verde", @"Naranja", @"Negro", @"Blanco", @"Gris"];
        [_selectOptionField setName:kselectOptionField];
        [_selectOptionField setSingleSelection:YES];
        [_selectOptionField setErrorMessageInValidationBlock:^NSString *(NSArray *arrayToValidate) {
            NSString *errorMessage = nil;
            if (!errorMessage) errorMessage = self.arrayValidationHelper.required(arrayToValidate);
            return errorMessage;
        }];
    }
    return _selectOptionField;
}

-(JRTFormSelectTableViewCell *)selectMultipleOptionField
{
    if (!_selectMultipleOptionField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldSelectTableViewCell bundle:nil] forCellReuseIdentifier:kselectMultipleOptionField];
        _selectMultipleOptionField =  [self.tableView dequeueReusableCellWithIdentifier:kselectMultipleOptionField];
        _selectMultipleOptionField.options = @[@"Rojo", @"Azul", @"Verde", @"Naranja", @"Negro", @"Blanco", @"Gris"];
        [_selectMultipleOptionField setName:kselectMultipleOptionField];
        [_selectMultipleOptionField setSingleSelection:NO];
        [_selectMultipleOptionField setErrorMessageInValidationBlock:^NSString *(NSArray *arrayToValidate) {
            NSString *errorMessage = nil;
            if (!errorMessage) errorMessage = self.arrayValidationHelper.required(arrayToValidate);
            if (!errorMessage) errorMessage = self.arrayValidationHelper.minLength(arrayToValidate, 2);
            if (!errorMessage) errorMessage = self.arrayValidationHelper.maxLength(arrayToValidate, 4);
            return errorMessage;
        }];
    }
    return _selectMultipleOptionField;
}

-(JRTFormSwitchTableViewCell *)switchField
{
    if (!_switchField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldSwitchTableViewCell bundle:nil] forCellReuseIdentifier:kswitchField];
        _switchField = [self.tableView dequeueReusableCellWithIdentifier:kswitchField];
        [_switchField setName:kswitchField];
    }
    return _switchField;
}

-(JRTFormMapTableViewCell *)mapField
{
    if (!_mapField)
    {
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldMapTableViewCell bundle:nil] forCellReuseIdentifier:kmapField];
        _mapField = [self.tableView dequeueReusableCellWithIdentifier:kmapField];
        [_mapField setName:kmapField];
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
        [self.tableView registerNib:[UINib nibWithNibName:kJRTFormFieldSubmitButtonTableViewCell bundle:nil] forCellReuseIdentifier:kSubmit];
        _submitButton = [self.tableView dequeueReusableCellWithIdentifier:kSubmit];
        [_submitButton setName:kSubmit];
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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
         if(indexPath.row == 0)     return self.textField;
    else if(indexPath.row == 1)     return self.secureTextField;
    else if(indexPath.row == 2)     return self.textViewField;
    else if(indexPath.row == 3)     return self.selectOptionField;
    else if(indexPath.row == 4)     return self.selectMultipleOptionField;
    else if(indexPath.row == 5)     return self.switchField;
    else if(indexPath.row == 6)     return self.mapField;
    else
    {
        return self.submitButton;
    }

}

@end
