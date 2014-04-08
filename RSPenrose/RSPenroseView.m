//
//  PenroseView.m
//  PenGreen
//
//  Created by Remi Santos on 01/02/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

#import "RSPenroseView.h"

@implementation RSPenroseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self customize];
    }
    return self;
}

-(void)customize
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    
    //// Color Declarations
   _leftColor = [UIColor whiteColor];
    _borderColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.5];
    _rightColor = [UIColor whiteColor];
    _topColor = [UIColor whiteColor];
    
    _selectColor = [UIColor colorWithRed:0.905882F green:0.905882F blue:0.905882F alpha:1.0F];

    self.currentSide = 0;
    [self selectSide:0];
}

-(void)selectSide:(int)side
{

    float angle = !self.canRotate ? 0 : [self rotateFromSide:self.currentSide toSide:side];
    self.layer.anchorPoint = CGPointMake(self.layer.anchorPoint.x, 0.38);
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeRotation(angle));
        [self setNeedsDisplay];
    }];
    
    self.currentSide = side;

}




- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
//    [super pointInside:point withEvent:event];
    BOOL pointInside = NO;

    if(self.superview.frame.origin.y < 0)
    {
        int y = 0 - self.frame.origin.y;
        if (CGRectContainsPoint(CGRectMake(130, y , 60, 70), point)) pointInside = YES;
    }
    else
    {
        pointInside = YES;
    }
    return pointInside;
}


#pragma mark - Rotation
-(float)rotateFromSide:(int)from toSide:(int)to
{
    float angle = 0;
    
    if(to == 0)
    {
        angle = 0;
    }
    else if(to == 1)
    {
        angle = 120;
    }
    else if(to == 2)
    {
        angle = -120;
    }
    return angle * M_PI / 180;
}


#pragma mark - draw Rect

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* leftColor = _leftColor;
    UIColor* rightColor = _rightColor;
    UIColor* topColor = _topColor;
    UIColor* strokeColor = _borderColor;
    
    if(self.colorSelectedSide)
    {
        switch (self.currentSide) {
            case 0:
                //top
                topColor = self.selectColor;
                break;
            case 1:
                //left
                leftColor = self.selectColor;
                break;
            case 2:
                //right
                rightColor = self.selectColor;
                break;
            default:
                break;
        }
    }
    
    //// Frames
    CGRect frame = CGRectMake(0, 0, 320, 280);
    
    
    //// Group
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 180.55, CGRectGetMinY(frame) + 279.97)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 139.45, CGRectGetMinY(frame) + 279.97)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 258.1, CGRectGetMinY(frame) + 72.34)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 103, CGRectGetMinY(frame) + 72.34)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 82.45, CGRectGetMinY(frame) + 36.37)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 319.75, CGRectGetMinY(frame) + 36.37)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 180.55, CGRectGetMinY(frame) + 279.97)];
        [bezierPath closePath];
        [rightColor setFill];
        [bezierPath fill];
        [strokeColor setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 299.24, CGRectGetMinY(frame) + 0.41)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 20.8, CGRectGetMinY(frame) + 0.41)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 139.45, CGRectGetMinY(frame) + 208.05)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 160, CGRectGetMinY(frame) + 172.08)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 82.45, CGRectGetMinY(frame) + 36.37)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 319.75, CGRectGetMinY(frame) + 36.37)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 299.24, CGRectGetMinY(frame) + 0.41)];
        [bezier2Path closePath];
        [topColor setFill];
        [bezier2Path fill];
        [strokeColor setStroke];
        bezier2Path.lineWidth = 2;
        [bezier2Path stroke];
        
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25, CGRectGetMinY(frame) + 36.37)];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 20.8, CGRectGetMinY(frame) + 0.41)];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 139.45, CGRectGetMinY(frame) + 208.05)];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 217, CGRectGetMinY(frame) + 72.34)];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 258.1, CGRectGetMinY(frame) + 72.34)];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 139.45, CGRectGetMinY(frame) + 279.97)];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25, CGRectGetMinY(frame) + 36.37)];
        [bezier3Path closePath];
        [leftColor setFill];
        [bezier3Path fill];
        [strokeColor setStroke];
        bezier3Path.lineWidth = 1;
        [bezier3Path stroke];
    }
}
@end
