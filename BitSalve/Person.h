//
//  Person.h
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define kPersonValidationDomain @"org.bitsalve.BitSalve.PersonValidationDomain"
#define kPersonValidationBirthdayCode 1000

@interface Person : NSManagedObject

@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain, readonly) NSNumber * age;

@end
