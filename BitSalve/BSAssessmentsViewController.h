//
//  BSAssessmentsViewController.h
//  BitSalve
//
//  Created by Mike Bylund on 5/4/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface BSAssessmentsViewController : UITableViewController

@property (strong, nonatomic) Patient *patient;

-(IBAction)doneButtonPressed:(id)sender;
-(IBAction)addButtonPressed:(id)sender;

@end
