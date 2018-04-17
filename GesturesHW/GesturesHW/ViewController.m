//
//  ViewController.m
//  GesturesHW
//
//  Created by Ivan Kozaderov on 16.04.2018.
//  Copyright © 2018 Ivan Kozaderov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property(weak,nonatomic) UIImageView* imageView;
@property(assign,nonatomic) CGFloat    imageViewScale;
@property(assign,nonatomic) CGFloat    imageViewRotation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage* image = [UIImage imageNamed:@"owl.png"];
   
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    
    self.imageView = imageView;
    self.imageView.image = image;
    
    [self.view addSubview:self.imageView ];
    
    
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    doubleTapGesture.numberOfTouchesRequired = 2;
    doubleTapGesture.numberOfTapsRequired    = 2;
    
    [self.view addGestureRecognizer:doubleTapGesture];
    
    
    UISwipeGestureRecognizer* rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    
    UISwipeGestureRecognizer* leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    pinchGesture.delegate = self;
    
    [self.view addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    
    rotationGesture.delegate = self;
    
    [self.view addGestureRecognizer:rotationGesture];
    
    
}

#pragma mark - Gestures

-(void)handleTap:(UITapGestureRecognizer*) tapGesture{
    
    NSLog(@"Tap");
    
    [self.imageView stopAnimating];
    
    CGPoint location = [tapGesture locationInView:self.view];
    
    [UIView animateWithDuration:0.5 animations:^{
     
        self.imageView.center = location;
        
    }];
    
}

-(void)handleDoubleTap:(UITapGestureRecognizer*) doubleTapGesture{

     NSLog(@"DoubleTap");
    
     [self.imageView.layer removeAllAnimations];
    
}
-(void)handleRightSwipe:(UISwipeGestureRecognizer*) rightSwipeGesture{
    
    NSLog(@"rightSwipe");
    
    [self.imageView stopAnimating];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform currentTransform = self.imageView.transform;
        
        self.imageView.transform = CGAffineTransformRotate(currentTransform,3.14);
        
        
    }];
    
    
}

-(void)handleLeftSwipe:(UISwipeGestureRecognizer*) leftSwipeGesture{
    
    NSLog(@"leftSwipe");
    
    [self.imageView stopAnimating];
    
    [UIView animateWithDuration:0.5 animations:^{

        CGAffineTransform currentTransform = self.imageView.transform;
        
        self.imageView.transform = CGAffineTransformRotate(currentTransform,-3.14);
        
    }];
    
    
}

-(void)handlePinch:(UIPinchGestureRecognizer*) pinchGesture{
    
    NSLog(@"Pinch");
    
    [self.imageView stopAnimating];
    
    [UIView animateWithDuration:0.5 animations:^{
        
    CGFloat newScale = 1. + pinchGesture.scale - self.imageViewScale;
    self.imageView.transform = CGAffineTransformMakeScale(self.imageViewScale, newScale);
    self.imageViewScale = pinchGesture.scale;
        
    }];
    
}

-(void)handleRotation:(UIRotationGestureRecognizer*) rotationGesture{
    
    NSLog(@"rotation");
    
    CGAffineTransform currentTransform = self.imageView.transform;
    
    [UIView animateWithDuration:2. animations:^{
        
        self.imageView.transform = CGAffineTransformRotate(currentTransform,1. + rotationGesture.rotation - self.imageViewRotation);
        self.imageViewRotation = rotationGesture.rotation;
    }];
  
}

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]];
    
}

@end
