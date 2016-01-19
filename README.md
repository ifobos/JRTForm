# JRTForm
#### JRTForm is a tool that will help shorten the development time of your forms, without sacrificing the ability to:

#### 1. Easily customize the appearance of the form fields.
  * By customizing a new xib corresponding to a new subclass of the appropriate field, which must contain sub-views required by the form field and outlets properly connected to the references of the parent class.

![Demo](http://i.imgur.com/PBpySI3.png)


#### 2. Introducing custom code to validate the value contained in the fields.
  * Making use of the **“setErrorMessageInValidationBlock”** method which receives as a parameter a block which in turn receives the value that the user entered in the field and should return a string with the error message that is displayed next to the name field if there is an error with that value, otherwise if the field value is valid block should return nil. 

```objective-c
  [textField setErrorMessageInValidationBlock:^NSString *(NSString *stringToValidate)
        {
            NSString *errorMessage          = nil;
            if ([stringToValidate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
            {
                errorMessage = @"is required.";
            }
            return errorMessage;
        }];

```

#### 3. Customizing behavior in interaction with the user interface.
  * By creating a subclass you can access properties (outlets) that refer to elements in the form field interface, allowing programmatically modify. the you implement cell protocols Delegate corresponding to the type of form field, executing a block of code that the cell has the property, these properties are named the same name as the method in which they are executed which is specified in the protocol.
  
```objective-c
// To implement the - (BOOL)textFieldShouldReturn:(UITextField *)textField 
// method specified in the UITextFieldDelegate  protocol is only necessary 
// to specify a block of code to be executed instead of the method thus only 
// it needs to spend the blocks describing a specific behavior as an argument 
// to a specific instance of the field.

 [textField setShouldReturn:^BOOL(UITextField *textField)
        {
             [textField endEditing:YES];
             return NO;
        }];

```
####Each form field has 3 different states

#### ____________Initial____________ ___________Invalid___________ ___________Valid____________
![states](http://i.imgur.com/7BxBzfc.jpg)


Installation
-------------

####Cocoapod Method:-
**JRTForm** is available through CocoaPods, to install it simply add the following line to your Podfile:

>pod 'JRTForm'

####Source Code Method:-
Just drag and drop **JRTForm** directory from demo project to your project. That's it.

