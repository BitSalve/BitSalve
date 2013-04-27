//
//  BSCoreDataEditCell.m
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSCoreDataEditCell.h"
#import "BSCoreDataError.h"

@implementation BSCoreDataEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField.delegate = self;
    }
    return self;}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.textField.enabled = editing;
}

#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
        [self setValue:[self.person valueForKey:self.key]];
    else
        [self.textField becomeFirstResponder];
}

#pragma mark UITextFieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self validate];
}

- (IBAction)validate
{
    id val = self.value;
    NSError *error;
    if (![self.person validateValue:&val forKey:self.key error:&error]) {
        NSString *message = nil;
        if ([[error domain] isEqualToString:@"NSCocoaErrorDomain"]) {
            NSString *errorCodeStr = [NSString stringWithFormat:@"%d", [error code]];
            
            BSCoreDataError *coreDataError = [BSCoreDataError alloc];
            NSString *errorMessage = [coreDataError getErrorMessageForCode:errorCodeStr];
            NSDictionary *userInfo = [error userInfo];
            message = [NSString stringWithFormat:NSLocalizedString(@"Validation error on: %@\rFailure Reason: %@", @"Validation error on: %@, Failure Reason: %@)"), [userInfo valueForKey:@"NSValidationErrorKey"], errorMessage];
        }
        
        else
            message = [error localizedDescription];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Validation Error", @"Validation Error") message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"Fix", @"Fix"), nil];
        [alert show];
    }
}

- (BOOL)isEditable
{
    return YES;
}

@end
