//
//  Person.m
//  BitSalve
//
//  Created by Mike Bylund on 4/26/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "Person.h"


@implementation Person

// dynamic tells the compiler not to generate getters/setters for the attribute
@dynamic birthdate;
@dynamic dateCreated;
@dynamic firstName;
@dynamic lastName;
@dynamic middleName;
@dynamic nickname;
@dynamic namePrefix;
@dynamic sex;
@dynamic nameSuffix;
@dynamic age;

-(void)awakeFromInsert
{
    self.dateCreated = [NSDate date];
}

- (BOOL)validateBirthdate:(id *)ioValue error:(NSError **)outError
{
    NSDate *date = *ioValue;
    if ([date compare:[NSDate date]] == NSOrderedDescending) {
        if (outError != NULL) {
            NSString *errorStr = NSLocalizedString(@"Birthdate cannot be in the future", @"Birthdate cannot be in the future");
            NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorStr forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:kPersonValidationDomain code:kPersonValidationBirthdayCode userInfo:userInfoDict];
            *outError = error;
        }
        return NO;
    }
    return YES;
}

// derive age from date of birth
- (NSNumber *)age
{
    if (self.birthdate == nil)
        return nil;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self.birthdate toDate:[NSDate date]options:0];
    NSInteger years = [components year];
    
    return [NSNumber numberWithInteger:years];
}

@end
