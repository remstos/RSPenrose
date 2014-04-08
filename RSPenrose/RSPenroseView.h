//
//  PenroseView.h
//  PenGreen
//
//  Created by Remi Santos on 01/02/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RSPenroseView : UIView
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *rightColor;
@property (nonatomic, strong) UIColor *leftColor;

@property (nonatomic) int currentSide;

@property (nonatomic) BOOL canRotate;

@property (nonatomic) BOOL colorSelectedSide;
@property (nonatomic, strong) UIColor *selectColor;


-(void)selectSide:(int)side;
@end
