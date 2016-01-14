//
//  DrawView.m
//  PdfTest
//
//  Created by 王宇 on 16/1/12.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property(nonatomic,strong)UIPanGestureRecognizer* panGeusture;

@property(nonatomic,assign) BOOL isDraw;

@property(nonatomic,strong) UIBezierPath* drawPath;
@property(nonatomic,assign) CGPoint initialPoint;
@end


@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    if (_isDraw) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        [self.drawPath stroke];
        CGContextRestoreGState(ctx);
    }
}


-(void)didMoveToWindow{
    [super didMoveToWindow];
    self.panGeusture = [[UIPanGestureRecognizer alloc]init];
    _isDraw = NO;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
}


-(void)setPanGeusture:(UIPanGestureRecognizer *)panGeusture{
    if (_panGeusture != nil) {
        return;
    }
    _panGeusture = panGeusture;
    [_panGeusture addTarget:self action:@selector(handlePanGeusture:)];
    [self addGestureRecognizer:_panGeusture];
    
}


-(void)handlePanGeusture:(UIPanGestureRecognizer*)panGesutre{
    
    CGPoint location = [panGesutre locationInView:self];
    switch (panGesutre.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isDraw = YES;
            _initialPoint = location;
            self.drawPath = [UIBezierPath bezierPath];
            [self.drawPath moveToPoint:_initialPoint];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.drawPath addLineToPoint:location];
            [self setNeedsDisplay];
        }
            break;
            
        default:
        {
            _isDraw = NO;
        }
            break;
    }
    
}


#pragma mark -- setter 


-(void)setDrawPath:(UIBezierPath *)drawPath{
    _drawPath = drawPath;
    _drawPath.lineWidth = 5;
    _drawPath.lineCapStyle = kCGLineCapRound;
    _drawPath.lineJoinStyle = kCGLineJoinRound;
}


@end
