//
//  UIViewController+RSPenrose.m
//  DemoPenrose
//
//  Created by Remi Santos on 08/02/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import "UIViewController+RSPenrose.h"

@implementation UIViewController (RSPenrose)

- (RSPenroseViewController *)rootPenroseController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[RSPenroseViewController class]]) {
            return (RSPenroseViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}
@end
