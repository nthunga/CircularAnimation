//
//  ViewController.m
//  CircularAnimation
//
//  Created by Naveen Thunga on 15/10/15.
//  Copyright © 2015 YMedia Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *highlightedTrack;
@property (nonatomic, strong) UIImageView *nonHighlightedTrack;

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) UIImage *nonHighlightedImage;
@property (nonatomic, strong) UIImage *highlightedImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    [self latchCellEndUnlockingAnimation:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)latchCellEndUnlockingAnimation:(NSString*)latchName{
        // Animating ring animation

        _nonHighlightedImage = [UIImage imageNamed:@"loader"];
        _highlightedImage = [UIImage imageNamed:@"loader_fill"];

        if (!self.highlightedTrack) {
            self.highlightedTrack = [[UIImageView alloc] initWithImage:_highlightedImage];
            
            [self.highlightedTrack setBackgroundColor:[UIColor clearColor]];
            self.highlightedTrack.frame = CGRectMake( (self.view.frame.size.width/2 - _nonHighlightedImage.size.width/2 ) ,
                                                     (self.view.frame.size.height/2 - _nonHighlightedImage.size.height/2 ),
                                                     _nonHighlightedImage.size.width,
                                                     _nonHighlightedImage.size.height);
            [self.view addSubview:self.highlightedTrack];
        }
        
        if (!self.nonHighlightedTrack) {
            self.nonHighlightedTrack = [[UIImageView alloc] initWithImage:_nonHighlightedImage];
            [self.nonHighlightedTrack setBackgroundColor:[UIColor redColor]];
            self.nonHighlightedTrack.alpha = 0.7f;
            self.nonHighlightedTrack.frame = CGRectMake( (self.view.frame.size.width/2 - _nonHighlightedImage.size.width/2 ) ,
                                                        (self.view.frame.size.height/2 - _nonHighlightedImage.size.height/2 ),
                                                        _nonHighlightedImage.size.width,
                                                        _nonHighlightedImage.size.height);
            [self.view addSubview:self.nonHighlightedTrack];
        }
        
        if (!self.trackLayer) {
            self.trackLayer = [CAShapeLayer new];
            self.trackLayer.fillColor = [UIColor clearColor].CGColor;
            self.trackLayer.strokeColor = [UIColor redColor].CGColor;
            self.trackLayer.frame = self.nonHighlightedTrack.bounds;
            self.trackLayer.strokeEnd = 1.0;
            self.trackLayer.lineWidth = 25.0;
            self.trackLayer.shadowOpacity = 0.25;
            [[self.view layer] addSublayer:self.trackLayer];
        }
        
        CGFloat radius = 120;
        
        CGFloat xPoint = self.nonHighlightedTrack.center.x - self.nonHighlightedTrack.frame.origin.x;
        CGFloat yPoint = self.nonHighlightedTrack.center.y - self.nonHighlightedTrack.frame.origin.y;
        
        self.trackLayer.path = [UIBezierPath bezierPathWithArcCenter : CGPointMake(xPoint,yPoint)
                                                              radius : radius
                                                          startAngle : -M_PI_2
                                                            endAngle : 2 * M_PI
                                                           clockwise : YES].CGPath;
        
        CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        drawAnimation.duration            = 3.0;
        drawAnimation.repeatCount         = 10.0;
        drawAnimation.removedOnCompletion = NO;
        
        // This will redraw semicircle from begining
        float fromValue = 0.0f;
        
        drawAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
        drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
        drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.trackLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
        self.nonHighlightedTrack.layer.mask = self.trackLayer;
}

@end
