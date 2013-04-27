//
//  BSCoreDataCell.m
//  
//
//  Created by Mike Bylund on 4/27/13.
//
//

#import "BSCoreDataCell.h"

@implementation BSCoreDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // TODO - use Auto Layout to adjust sizes
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(12.0, 15.0, 67.0, 15.0)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        self.label.textAlignment = NSTextAlignmentRight;
        self.label.textColor = [[UIColor alloc] initWithRed:0.321569f green:.4f blue:.568627f alpha:1.0f];
        self.label.text = @"label";
        [self.contentView addSubview:self.label];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(93.0, 13.0, 170.0, 19.0)];
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.enabled = NO;
        self.textField.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        self.textField.text = @"Title";
        [self.contentView addSubview:self.textField];
    }
    return self;
}

#pragma mark - Property Overrides

- (id)value
{
    return self.textField.text;
}

- (void)setValue:(id)newValue
{
    if ([newValue isKindOfClass:[NSString class]])
        self.textField.text = newValue;
    else
        self.textField.text = [newValue description];
}

#pragma mark - Instance Methods

- (BOOL)isEditable
{
    return NO;
}


@end
