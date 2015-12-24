//
//  ViewController.m
//  UIVisualEffectViewDemo
//
//  Created by SOTSYS021 on 18/09/15.
//  Copyright (c) 2015 Vikita. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBlurView];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    UISwipeGestureRecognizer *showMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleGesture:)];
    showMenuGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:showMenuGesture];
    
    
    UISwipeGestureRecognizer *hideMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleGesture:)];
    hideMenuGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:hideMenuGesture];


}
-(void)setBlurView{
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             -self.view.frame.size.height+70,
                                                             self.view.frame.size.width,
                                                             self.view.frame.size.height)];
    
    self.menuView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.menuView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(effectView.frame.size.width/2-20, effectView.frame.size.height/2, 80,80)];
    lbl.text=@"Demo";
    [effectView addSubview:lbl];
    
    [self.menuView addSubview:effectView];
}
-(void)handleGesture:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        [self toggleMenu:YES];
    }
    else{
        [self toggleMenu:NO];
    }
}
-(void)toggleMenu:(BOOL)shouldOpenMenu{
    
    [self.animator removeAllBehaviors];
    
    CGFloat gravityDirectionX = (shouldOpenMenu) ? 1.0 : -1.0;
   // CGFloat pushMagnitude = (shouldOpenMenu) ? 20.0 : -20.0;
    CGFloat boundaryPointX = (shouldOpenMenu) ? self.view.frame.size.height :-self.view.frame.size.height+70;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.menuView]];
    gravityBehavior.gravityDirection = CGVectorMake(0.0, gravityDirectionX);
    [self.animator addBehavior:gravityBehavior];
    
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.menuView]];
    [collisionBehavior addBoundaryWithIdentifier:@"menuBoundary"
                                       fromPoint:CGPointMake(100,boundaryPointX )
                                         toPoint:CGPointMake(200, boundaryPointX)];
   

    [self.animator addBehavior:collisionBehavior];
    
//    
//    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.menuView]
//                                                                    mode:UIPushBehaviorModeInstantaneous];
//    pushBehavior.magnitude = pushMagnitude;
//    [self.animator addBehavior:pushBehavior];
    
    
    UIDynamicItemBehavior *menuViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.menuView]];
    menuViewBehavior.elasticity = 0.5;
    [self.animator addBehavior:menuViewBehavior];
    
}
- (IBAction)btnClick:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
