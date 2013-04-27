//
//  Patient.h
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"

@interface Patient : Person

@property (nonatomic, retain) NSString * patientID;

@end
