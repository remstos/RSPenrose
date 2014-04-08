//
//  SettingsViewController.m
//  DemoPenrose
//
//  Created by Remi Santos on 08/04/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.rootPenroseController.sideAppear == RSPenroseSideAppearTop)
        [_sideSwitch setOn:YES];
    else
        [_sideSwitch setOn:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)switchChanged:(UISwitch *)sender {
    if (sender.on)
    {
        [self.rootPenroseController setSide:RSPenroseSideAppearTop];
        [self.rootPenroseController togglePenroseView];
    }
    else
    {
        [self.rootPenroseController setSide:RSPenroseSideAppearBottom];
        [self.rootPenroseController togglePenroseView];
    }
}
@end
