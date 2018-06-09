//
//  ViewController.m
//  mapSearch
//
//  Created by yan feng on 2018/3/31.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "Model.h"
#import "MapViewController.h"


static NSString * const mycellID = @"MyCellID";


@interface ViewController ()<UISearchBarDelegate ,UITableViewDelegate,UITableViewDataSource>
@property(strong , nonatomic)UISearchBar *searchBar;
@property(strong , nonatomic)UITableView *mytableView;
@property(strong , nonatomic)UILabel *messageLabel;
@property(strong , nonatomic)NSString * input ;
@property(strong , nonatomic)NSArray *sourceArr;
@property(strong , nonatomic)MBProgressHUD * hud;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview: self.searchBar];
    [self.view addSubview:self.mytableView];
    [self.view addSubview:self.messageLabel];
    [self controlConstraints];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark --- Request Data
-(void)getData{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Model getAllResultwithAddress:_input withCallback:^(NSArray *Array, BOOL success)  {
        if (success) {
            if (Array.count==0) {
                self.messageLabel.hidden = NO;
                self.mytableView.hidden = YES;
            }else{
                self.messageLabel.hidden=YES;
                self.mytableView.hidden = NO;
                self.sourceArr =[NSArray arrayWithArray:Array];
                [self.mytableView reloadData];
            }
            [self.hud removeFromSuperview];
        }else{
            [self.hud removeFromSuperview];
      }
       
    }];
}

#pragma mark  --- Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sourceArr.count<=1) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
    if (section==0) {
        return 1;
    }
    return self.sourceArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:mycellID forIndexPath:indexPath];
    if (self.sourceArr.count!=0) {
         [cell setDataWithMobile:self.sourceArr[indexPath.row] section:indexPath.section row:indexPath.row arrcount:self.sourceArr.count];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapViewController *vc = [[MapViewController alloc]init];
    if (self.sourceArr.count>1&&indexPath.section == 0 ) {
        vc.allmodel = self.sourceArr;
    }else{
        DetailModel *model = self.sourceArr[indexPath.row];
        vc.passModel = model;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.00;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 10.00;
    }
    return 0.01;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _input = searchBar.text;
//    [self.hub setHidden:NO];
    [self getData];
    
}

#pragma mark --- Constraints for MessageLabel
-(void)controlConstraints{
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.offset(200);
        make.height.offset(60);
    }];
}

#pragma mark --- lazy
-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width-20, 60)];
        self.searchBar.delegate = self;
    }
    return _searchBar;
}
-(UITableView *)mytableView{
    if(!_mytableView){
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame)+20, self.view.frame.size.width, self.view.frame.size.height - 80-24) style:UITableViewStyleGrouped];
        _mytableView.delegate =self;
        _mytableView.dataSource = self;
        _mytableView.hidden = YES;
        [_mytableView registerClass:[MyCell class] forCellReuseIdentifier:mycellID];
    }
    return _mytableView;
}
-(UILabel *)messageLabel{
    if(!_messageLabel){
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"No result" ;
        _messageLabel.font  = [UIFont systemFontOfSize:30];
        _messageLabel.textColor = [UIColor redColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.hidden = YES;
    }
    return _messageLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
