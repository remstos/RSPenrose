//
//  RootPenroseViewController.m
//  DemoPenrose
//
//  Created by Remi Santos on 08/04/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import "RootPenroseViewController.h"

@interface RootPenroseViewController ()

@end

@implementation RootPenroseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib
{
    // Change side appear
    [self setSide:RSPenroseSideAppearTop];
    // OR
    //[self setSide:RSPenroseSideAppearBottom];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sides Colors
    [self.penroseView setLeftColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
    [self.penroseView setRightColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
    [self.penroseView setTopColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
    [self.penroseView setColorSelectedSide:YES];
    [self.penroseView setSelectColor:[UIColor colorWithRed:0.874510F green:0.945098F blue:0.929412F alpha:0.97F]];
    
    
    
    // Add buttons
    [self addButtonsToTop:@"First" left:@"Second" right:@"Settings"];
    // OR
    //[self addButtonsToPenroseViewWithTitles:@[@"First",@"Second",@"Settings"]];
    // OR
    //[self addButtonsToPenroseView:@[/* -- Array of UIButton -- */]];
    
    
    // Initializa main controller
    [self setMainControllerWithStoryboardID:@"FirstVC"];
    [self.penroseView selectSide:0];

    [self showTuto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - RSPenroseViewController Delegate
-(void)didSelectPenroseButtonAtIndex:(int)index
{
    switch (index) {
        case 0:
            [self setMainControllerWithStoryboardID:@"FirstVC"];
            [self.penroseView selectSide:0];
            break;
        case 1:
            [self setMainControllerWithStoryboardID:@"SecondVC"];
            [self.penroseView selectSide:1];
            break;
        case 2:
            [self setMainControllerWithStoryboardID:@"ThirdVC"];
            [self.penroseView selectSide:2];
            break;
        default:
            break;
    }
}
-(void)didShowPenrose
{
    NSLog(@"Penrose Did Show");
}
-(void)didHidePenrose
{
    NSLog(@"Penrose Did Hide");
}

#pragma mark - Penrose Tuto
-(void)showTuto
{
    tutoImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    tutoImageView.image = [UIImage imageNamed:@"tutoA"];
    [self.view addSubview:tutoImageView];
    tutoState = 1;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if(tutoState == 1)
    {
        [UIView transitionWithView:self.view duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            tutoImageView.image = [UIImage imageNamed:@"tutoB"];
        } completion:nil];
        tutoState = 2;
    }else
    {
        [UIView animateWithDuration:0.7 animations:^{
            tutoImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [tutoImageView removeFromSuperview];
        }];
    }
    
}
@end
