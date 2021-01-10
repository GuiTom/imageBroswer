//
//  ViewController.m
//  ImageBrowser
//
//  Created by ChenChao on 2021/1/8.
//  Copyright © 2021 ChenChao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *showImgView;
    CGFloat lastScale;

     CGRect oldFrame;    //保存图片原来的大小

    CGRect largeFrame;  //确定图片放大最大的程度
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    showImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20,20, 320, 480)];

    
    
    [showImgView setMultipleTouchEnabled:YES];

    [showImgView setUserInteractionEnabled:YES];

    [showImgView setImage:[UIImage imageNamed:@"1.jpg"]];

    oldFrame = showImgView.frame;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    largeFrame = CGRectMake(0 - screenSize.width, 0 - screenSize.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height);

    [self addGestureRecognizerToView:showImgView];

    [self.view addSubview:showImgView];


}

 - (void) addGestureRecognizerToView:(UIView *)view

{

// 旋转手势

     UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];

    [view addGestureRecognizer:rotationGestureRecognizer];

    // 缩放手势

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];

    [view addGestureRecognizer:pinchGestureRecognizer];

     // 移动手势

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];

    [view addGestureRecognizer:panGestureRecognizer];

}
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer {

UIView *view = rotationGestureRecognizer.view;

 if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged)

{

view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);

[rotationGestureRecognizer setRotation:0];

}
}
// 处理缩放手势

- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{

UIView *view = pinchGestureRecognizer.view;

if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged)

{
//    CGAffineTransform trans = view.transform;

    CGPoint point =  [pinchGestureRecognizer locationInView:view];

    CGPoint ratioPoint = CGPointMake(point.x/view.bounds.size.width, point.y/view.bounds.size.height);
    

    
    CGFloat deltaX =  (ratioPoint.x-view.layer.anchorPoint.x)*view.bounds.size.width;
    CGFloat deltaY =  (ratioPoint.y-view.layer.anchorPoint.y)*view.bounds.size.height;
  

    
    view.layer.anchorPoint = ratioPoint;
    //anchorPoint 的变化会导致x,y 坐标的变化，在这里修正
    view.transform = CGAffineTransformTranslate(view.transform, deltaX, deltaY);
    view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
   
     pinchGestureRecognizer.scale = 1;
 
}

}


// 处理拖拉手势

- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer

{

UIView *view = panGestureRecognizer.view;

 if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged)

{

CGPoint translation = [panGestureRecognizer translationInView:view.superview];

[view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];

 [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];   }

}






@end
