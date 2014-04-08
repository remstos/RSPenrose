//
//  UIViewController+RSPenrose.h
//  DemoPenrose
//
//  Created by Remi Santos on 08/02/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPenroseViewController.h"

@class RSPenroseViewController;

@interface UIViewController (RSPenrose)

@property (nonatomic, weak, readonly) RSPenroseViewController *rootPenroseController;

@end
