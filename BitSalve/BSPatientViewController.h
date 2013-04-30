//
//  BSPatientViewController.h
//  BitSalve
//
//  Created by Mike Bylund on 4/27/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface BSPatientViewController : UIViewController <UITableViewDelegate>

@property (strong, nonatomic) Patient *patient;
@property (strong, nonatomic) IBOutlet UILabel *patientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *patientInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *patientIDLabel;

@property NSString *selectedActionType;

@end
