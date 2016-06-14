//
//  JRTFormPhoneNumberTableViewCell.m
//  JRTForm
//
//  Created by Nelson Rivera on 6/13/16.
//  Copyright © 2016 Juan Garcia. All rights reserved.
//

#import "JRTFormPhoneNumberTableViewCell.h"
#import <NBAsYouTypeFormatter.h>

NSString *const kJRTFormFieldPhoneNumberTableViewCell = @"JRTFormPhoneNumberTableViewCell";

@interface JRTFormPhoneNumberTableViewCell ()
@property (strong, nonatomic) NBAsYouTypeFormatter *formatter;
@end

@implementation JRTFormPhoneNumberTableViewCell

- (NBAsYouTypeFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NBAsYouTypeFormatter alloc] initWithRegionCode:@"US"];
    }
    return _formatter;
}

- (IBAction)editingChangedAction:(UITextField *)textField {
    NSString *cleanedText = [[[[textField.text
                                stringByReplacingOccurrencesOfString:@" " withString:@""]
                               stringByReplacingOccurrencesOfString:@"-" withString:@""]
                              stringByReplacingOccurrencesOfString:@"(" withString:@""]
                             stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    
    NSString * newText = [self.formatter inputString:cleanedText];
    
    
    if (![textField.text isEqualToString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
        
        UITextRange *textRange  = [textField.selectedTextRange copy];
        NSInteger startOffset   = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textRange.start];
        NSInteger endOffset     = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textRange.end];
        
        NSInteger formatCharactersInText = 0;
        NSInteger formatCharactersInNewText = 0;
        unichar findCharacter;
        for (int i = 0; i < startOffset; i++) {
            
            if (i < textField.text.length) {
                findCharacter = [textField.text characterAtIndex:i];
                if (findCharacter == ' ' || findCharacter == '-' || findCharacter == '(' || findCharacter == ')') {
                    formatCharactersInText ++;
                }
            }
            
            
            if (i < newText.length) {
                findCharacter = [newText characterAtIndex:i];
                if (findCharacter == ' ' || findCharacter == '-' || findCharacter == '(' || findCharacter == ')') {
                    formatCharactersInNewText ++;
                }
            }
            
        }
        
        NSInteger jumps = formatCharactersInNewText - formatCharactersInText;
        NSInteger scope = startOffset + jumps;
        
        for (int i = startOffset; i < scope; i++) {
            if (i < newText.length) {
                findCharacter = [newText characterAtIndex:i];
                if (findCharacter == ' ' || findCharacter == '-' || findCharacter == '(' || findCharacter == ')') {
                    jumps ++;
                }
            }
        }
        
        
        
        
        startOffset += jumps;
        endOffset   += jumps;
        
        NSInteger totalLengDiference = newText.length - textField.tag;
        
        
        
        while  ( startOffset < newText.length && startOffset > 0 && [cleanedText rangeOfString:[newText substringWithRange:NSMakeRange((startOffset<=0)? 0 : startOffset-1, 1)]].location == NSNotFound ) {
            if (totalLengDiference > 0) {
                startOffset++;
                endOffset++;
            }
            else {
                startOffset--;
                endOffset--;
            }
            
        }
        
        textField.text = newText;
        UITextPosition *from    = [textField positionFromPosition:[textField beginningOfDocument] offset:startOffset];
        UITextPosition *to      = [textField positionFromPosition:[textField beginningOfDocument] offset:endOffset];
        
        [textField setSelectedTextRange:[textField textRangeFromPosition:from toPosition:to]];
    }
    
    textField.tag = textField.text.length;
}

@end
