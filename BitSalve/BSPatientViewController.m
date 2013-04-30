//
//  BSPatientViewController.m
//  BitSalve
//
//  Created by Mike Bylund on 4/27/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSPatientViewController.h"
#import "BSChooseActionViewController.h"

@interface BSPatientViewController ()

@property (strong, nonatomic) BSChooseActionViewController *chooseActionController;
@property (strong, nonatomic) NSString *selectedAction;

@property (strong, nonatomic) UIBarButtonItem *doneButton;
@property (strong, nonatomic) UIBarButtonItem *addActionButton;
@property (strong, nonatomic) UISegmentedControl *actionTypeToggle;
- (void)done;
- (void)addAction;
- (void)actionTypeToggleChanged;

@end

@implementation BSPatientViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    // register the buttons to their selectors
    self.doneButton = [[self.navigationController.navigationBar.items objectAtIndex:0] leftBarButtonItem];
    self.addActionButton = [[self.navigationController.navigationBar.items objectAtIndex:0] rightBarButtonItem];
    self.actionTypeToggle = (UISegmentedControl*)[self.view viewWithTag:3];
    [self.actionTypeToggle addTarget:self action:@selector(actionTypeToggleChanged) forControlEvents:UIControlEventValueChanged];
    
    // update the patient info labels
    
    NSString *patientNameText = [[NSString alloc] initWithFormat:@"%@ %@ %@", self.patient.firstName, self.patient.middleName, self.patient.lastName];
    [self.patientNameLabel setText:patientNameText];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@", self.selectedActionType);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate Methods


#pragma mark - Instance Methods

-(void)done
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addAction
{
    
    [self performSegueWithIdentifier:@"ChooseActionType" sender:self.addActionButton];

}

-(void)actionTypeToggleChanged
{
    NSLog(@"Toggled!");
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ChooseActionType"]) {
        self.chooseActionController = segue.destinationViewController;
    }
}


@end
