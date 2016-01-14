//
//  BaseHttpApiManager.h
//  PdfTest
//
//  Created by 王宇 on 16/1/14.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BaseHttpApiManager;


#pragma mark 扩展类要遵守的协议，

@protocol HttpApiManagerProtocol <NSObject>



-(NSString*)apiReqeustName;

-(NSString*)apiRequestMethodName;

-(NSDictionary*)appendParamsWithReqeustName:(NSString*)reqeustName reqeustMethodsName:(NSString*)methodsName;


@end



@protocol HttpApiFetchResultDelegate <NSObject>


@optional

-(void)httpApiFetchResultDidSuccess:(BaseHttpApiManager*) baseApiManger;

-(void)httpApiFetchResultDidFailed:(NSError*)error;


@end



@protocol HttpResultReformerProtocol <NSObject>

@optional

// 一般返回一个实体类型，该实体类型可以用JSONModel来进行描述
-(NSDictionary*)reformDataWithHttpApiManager:(BaseHttpApiManager*) httpApiManager;

@end




@interface BaseHttpApiManager : NSObject


@property(nonatomic,assign)NSInteger tag;

@property(nonatomic,weak) id<HttpApiFetchResultDelegate> delegate;

@property(nonatomic,weak,readonly) NSData* rawData;


-(void)sendAsyncGetReqeust;

-(void)sendAsyncPostReqeust;

-(NSDictionary*)fetchDataWithReformer:(id<HttpResultReformerProtocol>)reformer;




@end
