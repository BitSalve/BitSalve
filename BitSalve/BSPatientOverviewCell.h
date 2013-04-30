//
//  BSPatientOverviewCell.h
//  BitSalve
//
//  Created by Mike Bylund on 4/28/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPatientOverviewCell : UITableViewCell

@property (strong, nonatomic) UILabel IBOutlet *patientName;
@property (strong, nonatomic) UILabel IBOutlet *patientDetails;
@property (strong, nonatomic) UILabel IBOutlet *patientID;

@end
