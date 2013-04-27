//
//  BSCoreDataError.m
//  BitSalve
//
//  Created by Mike Bylund on 4/27/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import "BSCoreDataError.h"

static NSDictionary *__CoreDataErrors;

@implementation BSCoreDataError

+ (void)initialize
{
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"CoreDataErrors" withExtension:@"plist"];
    
    __CoreDataErrors = [NSDictionary dictionaryWithContentsOfURL: plistURL];
}


-(NSString*)getErrorMessageForCode: (NSString*)errorCode
{
    NSString *errorMessage = [__CoreDataErrors valueForKey: errorCode];

    return errorMessage;
}



@end
