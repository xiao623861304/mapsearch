//
//  AddressEntity+CoreDataProperties.m
//  mapSearch
//
//  Created by yan feng on 2018/4/1.
//  Copyright © 2018年 Yan feng. All rights reserved.
//
//

#import "AddressEntity+CoreDataProperties.h"

@implementation AddressEntity (CoreDataProperties)

+ (NSFetchRequest<AddressEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AddressEntity"];
}

@dynamic name;
@dynamic location_lat;
@dynamic location_lng;
@dynamic address;

@end
