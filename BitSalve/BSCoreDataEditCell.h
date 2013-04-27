//
//  BSCoreDataEditCell.h
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSCoreDataCell.h"

@interface BSCoreDataEditCell : BSCoreDataCell <UITextFieldDelegate, UIAlertViewDelegate>

-(IBAction) validate;


@end
