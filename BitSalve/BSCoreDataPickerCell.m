//
//  BSCoreDataPickerCell.m
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSCoreDataPickerCell.h"

@interface BSCoreDataPickerCell()
@property (strong, nonatomic) UIPickerView *pickerView;
@end

@implementation BSCoreDataPickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.textField.clearButtonMode = UITextFieldViewModeNever;
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        self.textField.inputView = self.pickerView;
    }
    return self;
}

#pragma mark UIPickerViewDataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.values count];
}

#pragma mark - UIPickerViewDelegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.values objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.value = [self.values objectAtIndex:row];
}

#pragma mark - SuperDBEditCell Overrides

- (void)setValue:(id)value
{
    if (value != nil) {
        NSInteger index = [self.values indexOfObject:value];
        if (index != NSNotFound) {
            self.textField.text = value;
        }
    }
    else {
        self.textField.text = nil;
    }
}

@end
