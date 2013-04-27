//
//  BSCoreDataPickerCell.h
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSCoreDataEditCell.h"

@interface BSCoreDataPickerCell : BSCoreDataEditCell <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *values;
@end
