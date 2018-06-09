//
//  Model.m
//  mapSearch
//
//  Created by yan feng on 2018/3/31.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import "Model.h"

@class DetailModel;
@implementation Model
+ (NSDictionary *)objectClassInArray{
    return @{@"results" : DetailModel.class};
}

+(void)getAllResultwithAddress:(NSString *)address withCallback:(CallBack)callback{
    [SwpNetworking swpPOST:[NSString stringWithFormat:@"%@,%@,&,%@", BasicURL,address,formatted_address] parameters:nil swpNetworkingSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSDictionary *dic = (NSDictionary *) resultObject;
        Model *model = [Model mj_objectWithKeyValues:dic];
        callback(model.results,true);
    } swpNetworkingError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        callback(nil,false);
    }];
}
@end

@implementation DetailModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"Geometry" : @"geometry"
             };
}
@end

@implementation Geometry
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"DetailLocation" : @"location"
             };
}
@end

@implementation DetailLocation
@end
