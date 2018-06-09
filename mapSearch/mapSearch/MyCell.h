//
//  MyCell.h
//  mapSearch
//
//  Created by yan feng on 2018/3/31.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property(strong , nonatomic)UILabel *label;
- (void)setDataWithMobile:(NSObject *)model section:(NSInteger )section row:(NSInteger)row arrcount:(NSInteger)count;
@end
