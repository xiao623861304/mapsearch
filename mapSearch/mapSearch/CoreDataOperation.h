//
//  CoreDataOperation.h
//  mapSearch
//
//  Created by yan feng on 2018/4/1.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"


@interface CoreDataOperation : NSObject
-(void)initWithappDelegate;

-(void)insertData:(DetailModel *)model;
-(BOOL)checkData:(DetailModel *)model;
-(void)deleteData:(DetailModel *)model;
@end
