//
//  DrawOptimizeView.m
//  PdfTest
//
//  Created by 王宇 on 16/1/12.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "DrawOptimizeView.h"

@interface DrawOptimizeView ()

@property(nonatomic,strong) CAShapeLayer* shapeLayer;
@property(nonatomic,strong) UIBezierPath* drawPath;
@property(nonatomic,strong)UIPanGestureRecognizer* panGeusture;
@end

@implementation DrawOptimizeView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void)didMoveToWindow{
    [super didMoveToWindow];
    
    self.panGeusture = [[UIPanGestureRecognizer alloc]init];
}


-(void)layoutSubviews{
    [super layoutSubviews];
}



// mark: setter and getter


-(void)setShapeLayer:(CAShapeLayer *)shapeLayer{
    if (_shapeLayer == nil) {
        _shapeLayer = shapeLayer;
        _shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.strokeColor = [UIColor brownColor].CGColor;
        [self.layer addSublayer:_shapeLayer];
    }
    if (shapeLayer == nil) {
        [_shapeLayer removeFromSuperlayer];
        _shapeLayer = nil;
    }
}

-(void)setPanGeusture:(UIPanGestureRecognizer *)panGeusture{
    if (_panGeusture != nil) {
        return;
    }
    _panGeusture = panGeusture;
    [_panGeusture addTarget:self action:@selector(handlePanGeusture:)];
    [self addGestureRecognizer:_panGeusture];
}

-(void)handlePanGeusture:(UIPanGestureRecognizer*)panGesutre {
    CGPoint location = [panGesutre locationInView:self];
    switch (panGesutre.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.drawPath = [UIBezierPath bezierPath];
            [self.drawPath moveToPoint:location];
            self.shapeLayer = [CAShapeLayer layer];
            self.shapeLayer.lineWidth = self.drawPath.lineWidth;
            self.shapeLayer.path = self.drawPath.CGPath;
            
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.drawPath addLineToPoint:location];
            self.shapeLayer.path = _drawPath.CGPath;
        }
            break;
            
        default: // end 等状态
        {
            self.shapeLayer = nil;
            [self.drawPath closePath];
            self.shapeLayer.path = self.drawPath.CGPath;
        }
            break;
    }
}

#pragma mark -- setter and getter 

-(void)setDrawPath:(UIBezierPath *)drawPath{
    _drawPath = drawPath;
    _drawPath.lineWidth = 5;
    _drawPath.lineCapStyle = kCGLineCapRound;
    _drawPath.lineJoinStyle = kCGLineJoinRound;
}

@end
