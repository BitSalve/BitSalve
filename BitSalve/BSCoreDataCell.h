//
//  BSCoreDataCell.h
//  
//
//  Created by Mike Bylund on 4/27/13.
//
//

@interface BSCoreDataCell : UITableViewCell

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id value;

@property (strong, nonatomic) NSManagedObject *person;

- (BOOL)isEditable;

@end
