//
//  BSCoreDataError.h
//  BitSalve
//
//  Created by Mike Bylund on 4/27/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCoreDataError : NSObject

-(NSString*)getErrorMessageForCode: (NSString*)errorCode;

@end
