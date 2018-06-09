//
//  MyCell.m
//  mapSearch
//
//  Created by yan feng on 2018/3/31.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import "MyCell.h"
#import "Model.h"

@implementation MyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpView];
    }
    return self;
}
-(void)setDataWithMobile:(NSObject *)model section:(NSInteger)section row:(NSInteger)row arrcount:(NSInteger)count{
    DetailModel *dModel = (DetailModel *)model;
    if (count==1) {
        self.label.text = dModel.formatted_address;
    }else{
        if (section == 0 ) {
            self.label.text = @"Display All on Map";
        }else{
            self.label.text = dModel.formatted_address;
        }
    }
}
-(void)setUpView{
    [self addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(15);
    }];
}


-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
