//
//  AddressEntity+CoreDataProperties.h
//  mapSearch
//
//  Created by yan feng on 2018/4/1.
//  Copyright © 2018年 Yan feng. All rights reserved.
//
//

#import "AddressEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AddressEntity (CoreDataProperties)

+ (NSFetchRequest<AddressEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) float location_lat;
@property (nonatomic) float location_lng;
@property (nullable, nonatomic, retain) AddressEntity *address;

@end

NS_ASSUME_NONNULL_END
