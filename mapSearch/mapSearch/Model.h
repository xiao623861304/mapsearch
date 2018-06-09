//
//  Model.h
//  mapSearch
//
//  Created by yan feng on 2018/3/31.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(NSArray *Array , BOOL success);



@interface Model : NSObject
@property(strong , nonatomic)NSArray *results;
+(void)getAllResultwithAddress:(NSString *)address withCallback:(CallBack) callback;
@end


@class Geometry;
@interface DetailModel : NSObject
@property(strong , nonatomic)Geometry *geometry;
@property(strong , nonatomic)NSString * formatted_address;
@end

@class DetailLocation;
@interface Geometry :NSObject
@property(strong , nonatomic)DetailLocation *location;
@end

@interface DetailLocation : NSObject
@property(assign , nonatomic)CGFloat lat;
@property(assign , nonatomic)CGFloat lng;
@end
