//
//  RSPenroseViewController.h
//  PenGreen
//
//  Created by Remi Santos on 01/02/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPenroseView.h"
typedef enum _RSPenroseSideAppear {
    RSPenroseSideAppearTop = 0,
    RSPenroseSideAppearBottom
} RSPenroseSideAppear;

@class RSPenroseViewController;
@protocol RSPenroseViewControllerDelegate <NSObject>
@optional
-(void)didSelectPenroseButtonAtIndex:(int)index;
-(void)didClosePenrose;

@end



@interface RSPenroseViewController : UIViewController<RSPenroseViewControllerDelegate>


@property (nonatomic, assign) BOOL penroseRevealed;

@property (nonatomic) RSPenroseSideAppear sideAppear;

@property (nonatomic, strong) UIView *overlayBackground;
@property (nonatomic, assign) BOOL disableOverlay;

@property (nonatomic, strong) RSPenroseView *penroseView;
@property (nonatomic, strong) UIView *penroseViewContainer;

@property (nonatomic, strong) UIViewController *centerPanel; // required
@property (nonatomic, strong) UIView *centerPanelContainer;



-(void)setMainController:(UIViewController *)centerPanel;
-(void)setMainControllerWithStoryboardID:(NSString*)identifier;

-(void)addButtonsToPenroseView:(NSArray*)buttons;
-(void)addButtonsToPenroseViewWithTitles:(NSArray*)titles;
-(void)addButtonsToTop:(NSString*)top left:(NSString*)left right:(NSString*)right;

-(void)showPenroseView;
-(void)hidePenroseView;
-(void)togglePenroseView;
-(void)setSide:(RSPenroseSideAppear)sideAppear;
@end