//
//  main.m
//  PdfTest
//
//  Created by 王宇 on 16/1/11.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "fishhook.h"
#import <stdlib.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import "DPCatcher.h"
#define MAX_STEAL_MEM_NUM  (1024)

@class MemQueue;

static MemQueue* memQueue = nil;

static void (*orig_free)(void*);

static Class sDPCCatchIsa; // 获得DPCCatch的is指针
static size_t sDPCatchSize; // 或者实例对象需要的地址

static CFMutableSetRef registeredClasses;


@interface MemQueue : NSObject

// 当前的长度
@property(nonatomic,assign) NSInteger currentLength;


-(id)initWithCapacityLength:(NSInteger)length;

-(void)addToQueue:(void *)p;

-(void)free;


@end




@interface MemQueue ()

@property(nonatomic,strong)NSRecursiveLock* lock;

@property(nonatomic,strong)NSMutableArray* memArray;

@property(nonatomic,assign)NSInteger maxLength;



@end

@implementation MemQueue

-(id)initWithCapacityLength:(NSInteger)length{
    if (self = [super init]) {
        self.memArray = [@[] mutableCopy];
        self.lock = [[NSRecursiveLock alloc]init];
        self.maxLength = length;
    }
    return self;
}



-(void)addToQueue:(void *)p{
    [self.lock lock];
    if (self.memArray.count == self.maxLength) {
        void* willRemoveP = (__bridge void*)[self.memArray firstObject];
        [self.memArray removeObjectAtIndex:0];
        orig_free(willRemoveP);
    }
    [self.memArray addObject:(__bridge id _Nonnull)(p)];
    [self.lock unlock];
}

-(void)free{
    [self.lock lock];
    [self.memArray enumerateObjectsUsingBlock:^(id  _Nonnull p, NSUInteger idx, BOOL * _Nonnull stop) {
        void* willRemoveP = (__bridge void*)p;
        orig_free(willRemoveP);
    }];
    [self.memArray removeAllObjects];
    [self.lock unlock];
}


@end






void safe_free(void* p) {
#if 0
    size_t memSize = malloc_size(p);
    memset(p, 0x55, memSize);
    orig_free(p);
    
#else
    size_t memSize = malloc_size(p);
    if (memSize > sDPCatchSize) {
        // 获得需要释放的对象
        id obj = ( id)p;
        Class origClass = object_getClass(obj);
        if (origClass && CFSetContainsValue(registeredClasses, (__bridge const void *)(origClass))) {
            // 判断该对象的类是否在所有的类中
            memset(p, 0x55, memSize);
            memcpy(p, &sDPCCatchIsa, sizeof(void*)); // 将类的isa指针复制过来
            DPCatcher* bug = (__bridge DPCatcher*)p;
            bug.origClass = origClass;
            // 生成bug对象
        }else{
            memset(p, 0x55, memSize);
        }
    }else{
        memset(p, 0x55, memSize);
    }
    
#endif
    return;
    
}




int main(int argc, char * argv[]) {
    @autoreleasepool {
        //  memQueue = [[MemQueue alloc]initWithCapacityLength:MAX_STEAL_MEM_NUM];
        
#pragma mark -- 增加hook
        //        registeredClasses = CFSetCreateMutable(NULL, 0, NULL);
        //        unsigned int count = 0;
        //        Class* classes = objc_copyClassList(&count);
        //        for (unsigned int i = 0; i < count; i++) {
        //            CFSetAddValue(registeredClasses, (__bridge const void*)classes[i]);
        //        }
        //        free(classes);
        //        classes = NULL;
        //        sDPCCatchIsa = objc_getClass("DPCatcher");
        //        sDPCatchSize =  class_getInstanceSize(sDPCCatchIsa);
        //        rebind_symbols((struct rebinding[1]){{"free", safe_free, (void *)&orig_free}}, 1);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}



