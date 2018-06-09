//
//  CoreDataOperation.m
//  mapSearch
//
//  Created by yan feng on 2018/4/1.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import "CoreDataOperation.h"
#import "AddressEntity+CoreDataClass.h"
#import "AppDelegate.h"

@interface CoreDataOperation()
{
    AppDelegate *appDelegate;
    AddressEntity *dataFromCoreData;
}
@end
@implementation CoreDataOperation
-(void)insertData:(DetailModel *)model{
    AddressEntity *address = [NSEntityDescription insertNewObjectForEntityForName:@"AddressEntity" inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    if (![self checkData:model]) {
        address.name = model.formatted_address;
        address.location_lat = model.geometry.location.lat;
        address.location_lng = model.geometry.location.lng;
        [appDelegate saveContext];
    }else{
        NSLog(@"No found it ");
    }
}
-(BOOL)checkData:(DetailModel *)model{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AddressEntity"
                                              inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSArray *resultArray = [appDelegate.persistentContainer.viewContext executeFetchRequest:request
                                                                                      error:nil];
    for (AddressEntity *addr in resultArray) {
//        NSLog(@"====%@===%.6f===%.6f",addr.name , addr.location_lat,addr.location_lng);
        if([model.formatted_address isEqualToString:addr.name]||(model.geometry.location.lat==addr.location_lat)||(model.geometry.location.lng==addr.location_lng)){
            dataFromCoreData = addr;
            return true;
        }
    }
    return false;
}
-(void)deleteData:(DetailModel *)model{
//    NSLog(@"--------%@",dataFromCoreData);
    if ([self checkData:model]) {
       [appDelegate.persistentContainer.viewContext deleteObject:dataFromCoreData];
        [appDelegate saveContext];
    }else{
        NSLog(@"No found it ");
    }
}

-(void)initWithappDelegate{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}
@end
