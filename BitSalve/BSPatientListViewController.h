//
//  BSPatientListViewController.h
//  BitSalve
//
//  Created by Mike Bylund on 4/25/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPatientListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *patientTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
- (IBAction)addPatient:(id)sender;


@end
