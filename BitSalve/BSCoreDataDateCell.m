//
//  BSCoreDataDateCell.m
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSCoreDataDateCell.h"

static NSDateFormatter *__dateFormatter = nil;

@interface BSCoreDataDateCell ()

@property (strong, nonatomic) UIDatePicker *datePicker;
- (IBAction)datePickerChanged:(id)sender;

@end


@implementation BSCoreDataDateCell


+ (void)initialize
{
    __dateFormatter = [[NSDateFormatter alloc] init];
    [__dateFormatter setDateStyle:NSDateFormatterMediumStyle];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
        self.textField.inputView = _datePicker;
    }
    return self;
}


#pragma mark - SuperDBEditCell Overrides

- (id)value
{
    if (self.textField.text == nil || [self.textField.text length] == 0)
        return nil;
    
    return self.datePicker.date;
}

- (void)setValue:(id)value
{
    if (value != nil && [value isKindOfClass:[NSDate class]]) {
        [self.datePicker setDate:value];
        self.textField.text = [__dateFormatter stringFromDate:value];
    }
    else {
        self.textField.text = nil;
    }
}

#pragma mark - (Private) Instance Methods

- (IBAction)datePickerChanged:(id)sender
{
    NSDate *date = [self.datePicker date];
    self.value = date;
    self.textField.text = [__dateFormatter stringFromDate:date];
}

@end
