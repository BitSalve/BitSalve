//
//  BSPatientOverviewCell.m
//  BitSalve
//
//  Created by Mike Bylund on 4/28/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSPatientOverviewCell.h"

@implementation BSPatientOverviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PatientOverviewCell" owner:self options:nil];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
