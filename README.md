RSPenrose
=========

Original menu using a penrose triangle

It is a UIViewController container that show a Penrose triangle to change controller.
With multiple options you can drag the from the top or the bottom, add a button on each side of the triangle, turn the triangle to change controller, etc.

This is just for fun.

Screenshots
---
![RSPenrose 1]()

How to use 
---
1. Drag&Drop /RSPenrose folder in your project (With RSPenroseView - RSPenroseViewController - UIViewController+RSPenrose)
2. Create a subclass of `RSPenroseViewController`. I call it `RootPenroseViewController`.
3. In the Storyboard, create a blanck `UIViewController` and change it to a `RootPenroseViewController`.
4. In the Storyboard, add Storyboard Identifier to each other Controller you want, I have "FirstVC", "SecondVC" and "ThirdVC".
5. Add the following lines to `RootPenroseViewController.m`:

```  objc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add buttons
    [self addButtonsToTop:@"First" left:@"Second" right:@"Settings"];
    
    // Initializa main controller
    [self setMainControllerWithStoryboardID:@"FirstVC"];
    [self.penroseView selectSide:0];
}

```
6. Finally, to change controller when side is selected, add the following method (delegate method) :

```  objc

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
```

That's it !


Do More 
===

You can use the following options to customize or change behaviour.


Change the side on which the triangle appears
---

Penrose can appear from Top (default) or Top 
Add this in `RootPenroseViewController` `awakeFromNib`

```  objc
-(void)awakeFromNib
{
      // Change side appear
      [self setSide:RSPenroseSideAppearTop];
      // OR
      // [self setSide:RSPenroseSideAppearBottom];
}
```

Change colors
---

You can change the color of each side of the triangle and the selected side. 
Add this in `RootPenroseViewController` `viewDidLoad`

```  objc
  // Sides Colors
      [self.penroseView setLeftColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
      [self.penroseView setRightColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
      [self.penroseView setTopColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
      [self.penroseView setSelectColor:[UIColor colorWithRed:0.874510F green:0.945098F blue:0.929412F alpha:0.97F]];
```
And you can enable/disable if the selected side is with a different color :

```  objc
      [self.penroseView setColorSelectedSide:YES];
``` 

Disable rotation
---

You can disable the ability to rotate triangle 

```  objc
      [self.penroseView setCanRotate:NO];
```


Appear/Disappear
---

Toggle/Change the state of the triangle with this methods

```  objc
      [self.rootPenroseController togglePenroseView];
      [self.rootPenroseController hidePenroseView];
      [self.rootPenroseController showPenroseView];
```
And you can use the delegate methods in `RootPenroseViewController` :
```  objc
-(void)didShowPenrose
{
    NSLog(@"Penrose Did Show");
}
-(void)didHidePenrose
{
    NSLog(@"Penrose Did Hide");
}
``` 


UIViewController+RSPenrose.h
---

Access to the RootPenroseViewController on each child controller.
Just 

```  objc
 #import "UIViewController+RSPenrose.h"
```
And now you can do what you want !

```  objc
      [self.rootPenroseController setSide:RSPenroseSideAppearTop];
      [self.rootPenroseController togglePenroseView];
      /* ... */
```


Different buttons
---

You have three ways to add buttons to the triangle :

- Basic, on each sides passing titles as parameters

```  objc
      [self addButtonsToTop:@"First" left:@"Second" right:@"Settings"];
```
- Only on the top side passing titles as parameters

```  objc
      [self addButtonsToPenroseViewWithTitles:@[@"First",@"Second",@"Settings"]];
```
- Or on your own way, passing UIButtons as parameters

```  objc
      [self addButtonsToPenroseView:@[/* -- Array of UIButton -- */]];
```
