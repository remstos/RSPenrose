//
//  RSPenroseViewController.m
//  PenGreen
//
//  Created by Remi Santos on 01/02/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import "RSPenroseViewController.h"

#define _overlayAlpha 0.4

#define _animationDuration 0.5

@interface RSPenroseViewController ()
{
    CGRect basePenroseRect;
    float originYOut;
    //Gesture
    CGPoint locationStateBegan;
    CGPoint centerPenroseStateBegan;
    float lastRotation;
    float totalRotation;
    CGAffineTransform currentTransformPan;
}
@property (nonatomic,strong) NSMutableArray *menuButtons;
@end




@implementation RSPenroseViewController

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
    
    switch (self.sideAppear) {
        case RSPenroseSideAppearTop:
            originYOut = -215;
            break;
        case RSPenroseSideAppearBottom:
            originYOut = self.view.frame.size.height - 44;
            break;
        default:
            originYOut = -215;
            self.sideAppear = RSPenroseSideAppearTop;
            break;
    }
    self.penroseRevealed = NO;
    
    self.menuButtons = [[NSMutableArray alloc] init];
    
    //Init the center panel
    self.centerPanelContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.centerPanelContainer];
    [self.centerPanelContainer addSubview:self.centerPanel.view];
    
    //Init the overlay
    self.overlayBackground = [[UIView alloc] initWithFrame:self.view.bounds];
    self.overlayBackground.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    self.overlayBackground.alpha = _overlayAlpha;
    UITapGestureRecognizer *tapOverlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOverlayGesture:)];
    [self.overlayBackground addGestureRecognizer:tapOverlay];
    
    //Init the penrose view
    self.penroseView = [[RSPenroseView alloc] initWithFrame:CGRectMake(0, -34, 320, 280)];
    self.penroseViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, originYOut, 320, 280)];
    basePenroseRect = self.penroseViewContainer.frame;
    [self.view addSubview:self.penroseViewContainer];
    [self.penroseViewContainer addSubview:self.penroseView];
    
    UIPanGestureRecognizer *panPenrose = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPenroseGesture:)];
    [self.penroseViewContainer addGestureRecognizer:panPenrose];
    UITapGestureRecognizer *tapPenrose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPenroseGesture:)];
    [self.penroseViewContainer addGestureRecognizer:tapPenrose];
    
    UIRotationGestureRecognizer *rotatePenrose = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePenroseGesture:)];
    [self.penroseViewContainer addGestureRecognizer:rotatePenrose];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Set Main Controller
-(void)setMainControllerWithStoryboardID:(NSString*)identifier
{
    UIViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self setMainController:VC];
}
-(void)setMainController:(UIViewController *)centerPanel
{
    UIViewController *beforeController = self.centerPanel;
    self.centerPanel = centerPanel;
    [self.centerPanelContainer addSubview:self.centerPanel.view];
    self.centerPanel.view.alpha = 0;
    
    [beforeController removeFromParentViewController];
    [self addChildViewController:self.centerPanel];
    
    [UIView animateWithDuration:_animationDuration animations:^{
        beforeController.view.alpha = 0;
        self.centerPanel.view.alpha = 1;
    } completion:^(BOOL finished) {
        [beforeController.view removeFromSuperview];
    }];
}

#pragma mark - Buttons
-(void)buttonClicked:(UIButton*)sender
{
    if([self respondsToSelector:@selector(didSelectPenroseButtonAtIndex:)])
    {
        [self didSelectPenroseButtonAtIndex:(int)[self.menuButtons indexOfObject:sender]];
    }
    
    [self hidePenroseView];
}
-(void)addButtonsToPenroseViewWithTitles:(NSArray*)titles
{
    NSMutableArray *buttons= [[NSMutableArray alloc] init];
    float x = 35;
    float y = 0;
    float width = (self.penroseView.frame.size.width - 50) / titles.count;
    float height = 40;
    int i = 0;
    for (NSString *title in titles) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn1 setTitle:title forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        x = (i == 0)? x : x + (width);
        btn1.frame = CGRectMake(x, y, width, height);
        [buttons addObject:btn1];
        i++;
    }
    
    [self addButtonsToPenroseView:buttons];
}

-(void)addButtonsToTop:(NSString*)top left:(NSString*)left right:(NSString*)right
{
    float width = 180;
    float height = 35;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:top forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(15, 2, width,height);
    btn.center = CGPointMake(self.view.center.x, btn.center.y);
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:left forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(-5, 130, width,height);
    btn1.transform = CGAffineTransformMakeRotation((60 * M_PI / 180) + M_PI);
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:right forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(145, 130, width,height);
    btn2.transform = CGAffineTransformMakeRotation((-60 * M_PI / 180) + M_PI);
    
    [self addButtonsToPenroseView:@[btn,btn1,btn2]];
    self.penroseView.canRotate = YES;
    self.penroseView.colorSelectedSide = YES;
}
-(void)addButtonsToPenroseView:(NSArray*)buttons
{
    int i = 0;
    for (UIButton*button in buttons) {
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.penroseView addSubview:button];
        
        [self.menuButtons addObject:button];
        i++;
    }
}
#pragma mark - Gesture
-(void)tapPenroseGesture:(UITapGestureRecognizer*)gesture
{
    [self togglePenroseView];
}
-(void)tapOverlayGesture:(UITapGestureRecognizer*)gesture
{
    [self togglePenroseView];
}
-(void)panPenroseGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:self.view];
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        locationStateBegan = location;
        centerPenroseStateBegan = self.penroseViewContainer.center;
        if(!self.disableOverlay)
            [self.view insertSubview:self.overlayBackground belowSubview:self.penroseViewContainer];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    else
    {
        CGPoint newLocation = centerPenroseStateBegan;
        newLocation.y += location.y - locationStateBegan.y;
        self.penroseViewContainer.center = newLocation;
        
        if (gesture.state == UIGestureRecognizerStateEnded)
        {
            int minDistance = 50;
            float difference = newLocation.y - centerPenroseStateBegan.y;
            if (difference >= minDistance)
            {
                if (self.sideAppear == RSPenroseSideAppearBottom)
                    [self repositionPenroseViewToOrigin:YES];
                else if (self.sideAppear == RSPenroseSideAppearTop)
                    [self repositionPenroseViewToOrigin:NO];
            }
            else if (difference <= - minDistance)
            {
                if (self.sideAppear == RSPenroseSideAppearBottom)
                    [self repositionPenroseViewToOrigin:NO];
                else if (self.sideAppear == RSPenroseSideAppearTop)
                    [self repositionPenroseViewToOrigin:YES];
            }
            else
            {
                [self repositionPenroseViewToOrigin:NO];
            }
        }
        
        if (self.penroseViewContainer.center.y < 150)
        {
            self.overlayBackground.alpha = (self.penroseView.center.y / 150) * _overlayAlpha;
        }
        else
        {
            self.overlayBackground.alpha = _overlayAlpha;
        }
        
    }
    
    
    // If Penrose can rotate, rotate with one finger
    if(self.penroseView.canRotate)
    {
        if(gesture.state == UIGestureRecognizerStateBegan)
        {
            currentTransformPan = self.penroseView.transform;
            
            lastRotation = 0.0;
            totalRotation = 0.0;
        }
        else
        {
            CGFloat rotation = 0 - ((location.x - locationStateBegan.x)) / 100;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransformPan,rotation);
            
            [self.penroseView setTransform:newTransform];
            
            lastRotation = rotation;
            totalRotation += lastRotation;
            
            if(gesture.state == UIGestureRecognizerStateEnded)
            {
                
                int newSide = self.penroseView.currentSide;
                if( totalRotation >= 5)
                {
                    newSide++;
                    if (newSide > 2) {
                        newSide = 0;
                    }
                }
                else if( totalRotation <= -5)
                {
                    newSide--;
                    if (newSide < 0) {
                        newSide = 2;
                    }
                }
                [self.penroseView selectSide:newSide];
                if([self respondsToSelector:@selector(didSelectPenroseButtonAtIndex:)])
                {
                    [self didSelectPenroseButtonAtIndex:newSide];
                }
            }
        }
    }
}
-(void)rotatePenroseGesture:(UIRotationGestureRecognizer*)gesture
{
    if(!self.penroseRevealed || !self.penroseView.canRotate)
    {
        return;
    }
    if(gesture.state == UIGestureRecognizerStateBegan) {
        lastRotation = 0.0;
        totalRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (lastRotation - gesture.rotation);
    
    CGAffineTransform currentTransform = self.penroseView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [self.penroseView setTransform:newTransform];
    
    lastRotation = gesture.rotation;
    totalRotation += lastRotation;
    if(gesture.state == UIGestureRecognizerStateEnded) {
        int newSide = self.penroseView.currentSide;
        if( totalRotation >= 5)
        {
            newSide++;
            if (newSide > 2) {
                newSide = 0;
            }
        }
        else if( totalRotation <= -5)
        {
            newSide--;
            if (newSide < 0) {
                newSide = 2;
            }
        }
        
        [self.penroseView selectSide:newSide];
        if([self respondsToSelector:@selector(didSelectPenroseButtonAtIndex:)])
        {
            [self didSelectPenroseButtonAtIndex:newSide];
        }
        
    }
}
#pragma mark - Animation
-(void)repositionPenroseViewToOrigin:(BOOL)origin
{
    if(!self.disableOverlay)
    {
        [self.view insertSubview:self.overlayBackground belowSubview:self.penroseViewContainer];
    }
    
    CGRect rect = basePenroseRect;
    if(origin)
    {
        //replace to top
        rect.origin.y = originYOut;
        self.penroseRevealed = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        
    }
    else
    { //replace to center
        rect.origin.y = (self.view.frame.size.height / 2) - (self.penroseViewContainer.frame.size.height / 2);
        self.penroseRevealed = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    [UIView animateWithDuration:_animationDuration animations:^{
        self.penroseViewContainer.frame = rect;
        self.overlayBackground.alpha = self.penroseRevealed? _overlayAlpha : 0;
    } completion:^(BOOL finished) {
        [self toggleOverlayBackground];
    }];
    
}

-(void)toggleOverlayBackground
{
    if(!self.disableOverlay && self.penroseRevealed)
    {
        [self.overlayBackground removeFromSuperview];
        [self.view insertSubview:self.overlayBackground belowSubview:self.penroseViewContainer];
    }
    else
    {
        [self.overlayBackground removeFromSuperview];
    }
    
}
-(void)showPenroseView
{
    [self repositionPenroseViewToOrigin:NO];
}
-(void)hidePenroseView
{
    [self repositionPenroseViewToOrigin:YES];
}
-(void)togglePenroseView
{
    if(self.penroseRevealed)
    { //replace to top
        [self hidePenroseView];
    }
    else
    { //replace to center
        [self showPenroseView];
    }
}


-(void)setSide:(RSPenroseSideAppear)sideAppear
{
    self.sideAppear = sideAppear;
    switch (self.sideAppear) {
        case RSPenroseSideAppearTop:
            originYOut = -215;
            break;
        case RSPenroseSideAppearBottom:
            originYOut = self.view.frame.size.height - 44;
            break;
        default:
            originYOut = -215;
            self.sideAppear = RSPenroseSideAppearTop;
            break;
    }
}
@end
