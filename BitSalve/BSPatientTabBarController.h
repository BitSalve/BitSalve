//
//  BSPatientTabBarController.h
//  BitSalve
//
//  Created by Mike Bylund on 4/28/13.
//  Copyright (c) 2013 BitSalve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface BSPatientTabBarController : UITabBarController

@property (strong, nonatomic) Patient *patient;

@end
