//
//  PDFReadView.m
//  PdfTest
//
//  Created by 王宇 on 16/1/11.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "PDFReadView.h"

@implementation PDFReadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    
}


#pragma mark setter


-(NSString*)filePath{
    if (_filePath == nil) {
        _filePath = [[NSBundle mainBundle]pathForResource:@"Manual" ofType:@"pdf"];
    }
    return _filePath;
}

@end
