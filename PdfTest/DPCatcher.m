//
//  DPCatcher.m
//  PdfTest
//
//  Created by 王宇 on 16/1/13.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "DPCatcher.h"
#import <objc/runtime.h>
@implementation DPCatcher

// 执行重定向
-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    NSLog(@"发现objc野指针：%s::%p=> %@", class_getName(self.origClass), self, @"objc_msg_send");
    return nil;
}



-(void)dealloc {
    NSLog(@"发现objc野指针：%s::%p=> %@", class_getName(self.origClass), self, @"dealloc");
    abort();
}


-(instancetype)autorelease {
    NSLog(@"发现objc野指针：%s::%p=> %@", class_getName(self.origClass), self, @"autorelease");
    abort();
}


- (oneway void)release{
    NSLog(@"发现objc野指针：%s::%p=> %@", class_getName(self.origClass), self, @"release");
    abort();
}
@end
