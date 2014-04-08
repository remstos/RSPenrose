//
//  SettingsViewController.h
//  DemoPenrose
//
//  Created by Remi Santos on 08/04/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+RSPenrose.h"
@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *sideSwitch;

- (IBAction)switchChanged:(UISwitch *)sender;
@end
