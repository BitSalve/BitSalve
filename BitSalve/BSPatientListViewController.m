//
//  BSPatientListViewController.m
//  BitSalve
//
//  Created by Mike Bylund on 4/25/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSPatientListViewController.h"
#import "BSAppDelegate.h"
#import "BSPatientEditViewController.h"
#import "Patient.h"

@interface BSPatientListViewController ()
@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;

@end

@implementation BSPatientListViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Fetch any existing entities
    NSError *error = nil;
    
    if (![[self fetchedResultsController] performFetch:&error])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error loading data", @"Error loading data") message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.", @"Error was: %@, quitting."), [error localizedDescription]]delegate:self cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts") otherButtonTitles:nil];
        
        [alert show];
    }                                                                                            
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.patientTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PatientListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell. . .
    Patient *aPatient = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ %@ %@", [aPatient valueForKey:@"firstName"], aPatient.middleName ? aPatient.middleName : @"", [aPatient valueForKey:@"lastName"]];
    
    // build the detail label as: <sex>, <age> years  ie: "Male, 27yrs"
    NSString *sex = aPatient.sex ? aPatient.sex : @"";
    NSString *age = aPatient.age ? [[NSString alloc] initWithFormat:@"%@ yrs", aPatient.age] : @"" ;
    
    NSString *detail = [[NSString alloc] initWithFormat:@"%@ %@", sex, age];
    cell.detailTextLabel.text = detail;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *managedObjectContext = [self.fetchedResultsController managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        
        if (![managedObjectContext save:&error])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"Error saving entity",
                                                                  @"Error saving entity")
                                  message:
                                  [NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.",
                                                                               @"Error was: %@, quitting."),
                                   [error localizedDescription]]
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSManagedObject *selectedPatient = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"PatientSelectSegue" sender:selectedPatient];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSManagedObject *selectedPatient = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"PatientEditSegue" sender:selectedPatient];
}

#pragma mark - FetchedResultsController Property

- (NSFetchedResultsController *)fetchedResultsController {
    if(_fetchedResultsController != nil)
        return _fetchedResultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    BSAppDelegate *appDelegate = (BSAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    NSArray *sortDescriptiors = [[NSArray alloc] initWithObjects:sortDescriptor1, sortDescriptor2, nil];
    [fetchRequest setSortDescriptors:sortDescriptiors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName:@"Person"];
    
    [fetchRequest setSortDescriptors:sortDescriptiors];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

#pragma mark - NSFetchedResultsControllerDelegate Methods 

// notify the view displaying the patients that the patients are about to change
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.patientTableView beginUpdates];
}

// notify the view displaying the patients that the changes are through
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.patientTableView endUpdates];
}

// make the changes to the table view based on what has been updated
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.patientTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
        break;
        case NSFetchedResultsChangeDelete:
            [self.patientTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
        break;
    }
}

// 
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.patientTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.patientTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        break;
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
        break;
    }
}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    exit(-1);
}


- (IBAction)addPatient:(id)sender
{
    NSManagedObjectContext *managedObjectContext = [self.fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *patient = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error saving entity", @"Error saving entity")
                                                 message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.",@"Error was: %@, quitting."), [error localizedDescription]]
                                                 delegate:self cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
                                                 otherButtonTitles:nil];
        
        [alert show];
    }
    
    [self performSegueWithIdentifier:@"PatientEditSegue" sender:patient];
}

- (void) setEditing: (BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.addButton.enabled = !editing;
    [self.patientTableView setEditing:editing animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PatientEditSegue"]) {
        if ([sender isKindOfClass:[NSManagedObject class]]) {
            
            
            BSPatientEditViewController *detailController = segue.destinationViewController;
            detailController.patient = sender;
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Patient Detail Error", @"Hero Detail Error")
                                                            message:NSLocalizedString(@"Error trying to show Hero detail", @"Error trying to show Hero detail")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else if([segue.identifier isEqualToString:@"PatientSelectSegue"])
    {
        if ([sender isKindOfClass:[NSManagedObject class]]) {
            
            // get both the navigation controller and the top item, which is the table view displaying the patient info
            BSPatientTabBarController *navigationController = segue.destinationViewController;
            navigationController.patient = sender;
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Patient Detail Error", @"Hero Detail Error")
                                                            //message:NSLocalizedString(@"Error trying to show Hero detail", @"Error trying to show Hero detail")
                                                            message: [[NSString alloc] initWithFormat:@"%@", [[sender class] description]]
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end
