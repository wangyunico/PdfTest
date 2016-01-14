//
//  BaseHttpApiManager.m
//  PdfTest
//
//  Created by 王宇 on 16/1/14.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "BaseHttpApiManager.h"
#import <libkern/OSAtomic.h>

typedef NSInteger(^TagResp)();

@interface BaseHttpApiManager (){
    OSSpinLock _lock;
}

@property(nonatomic,weak) BaseHttpApiManager<HttpApiManagerProtocol>* weakSelf;

@property(nonatomic,weak,readwrite) NSData* rawData;

@property(nonatomic,strong)NSURL* baseUrl;


@end

@implementation BaseHttpApiManager



-(id)init{
    if (self = [super init]) {
        if ( [self conformsToProtocol:@protocol(HttpApiManagerProtocol)]) {
            self.weakSelf = (id<HttpApiManagerProtocol>)self;
            _tag = 0;
            _lock = OS_SPINLOCK_INIT;
        }else{
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"SubClass of Base HttpApoManager must confirm to HttpApiManagerProtocol" userInfo:nil];
        }
    }
    return self;
}


#pragma mark -- public methods
/**
 *  发送getter请求
 */
-(void)sendAsyncGetReqeust{
    
    __block NSInteger tag =  self.tag;
    TagResp tagRespBlock = ^{
        return tag;
    };
    // - 网络监测
    // - 调用weakSelf 实例的HttpApiManagerProtocol方法
    //   获得根据类型采用不同请求方式处理 {
    //   处理不同Reqeust类型
    //   1. sendReqeust失败后，要缓存合适几乎重发
    //   2. Reqeust是离线策略，连接wifi后出发发送
    //
    //}
    // - 获得访问的url子路径，获得methods参数
    // - 调用第三方框架如ASIHttp 或者 AFNetWork
    // - 调用第三方框架在在回调中调用Http HttpApiFetchResultDelegate
    
}


-(void)sendAsyncPostReqeust{
    
}

-(NSDictionary*)fetchDataWithReformer:(id<HttpResultReformerProtocol>)reformer{
    
    return [reformer performSelector:@selector(reformDataWithHttpApiManager:)withObject:self];
}


#pragma mark -- 在子类实现中可以业务化的一些Api ....

-(void) sendNextPageFetchRequest {
    // ....
}



#pragma mark -- getters 

-(NSURL*)baseUrl{
    if (_baseUrl == nil) {
        //
        NSString* urlConfigPath = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
        _baseUrl = [[NSDictionary dictionaryWithContentsOfFile:urlConfigPath]objectForKey:@"basePath"];
        
    }
    return _baseUrl;
}



@end
