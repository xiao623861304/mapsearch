//
//  MapViewController.m
//  mapSearch
//
//  Created by yan feng on 2018/4/1.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "CoreDataOperation.h"


NSString * const pinId = @"pinID";

@interface MapViewController ()<MKMapViewDelegate>
{
    UIBarButtonItem *rightBarItem;
    BOOL isExistData;
}
@property(strong , nonatomic)MKMapView *mapView;
@property(strong , nonatomic)CoreDataOperation *operationData;
@property(strong , nonatomic)MBProgressHUD * hud;
@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self addRightBtn];
    [self checkCoreData];
    [self.view addSubview:self.mapView];
    [self updateload];
}

#pragma mark  ---- right button
- (void)addRightBtn {
    rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark ---- click of right button
- (void)onClickedOKbtn {
    if ([rightBarItem.title isEqualToString:@"Delete"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Are your sure to delete it ?"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self.operationData deleteData:self.passModel];
                                                                  self->rightBarItem.title = @"Save";
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                        
//                                                                 NSLog(@"action = %@", action);
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text = @"Saving Success";
        self.hud.mode= MBProgressHUDModeText;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.operationData insertData:self.passModel];
            [self.hud removeFromSuperview];
            self->rightBarItem.title = @"Delete";
        });
      
    }
}

#pragma mark ----- check CoreData
-(void)checkCoreData{
    isExistData = [self.operationData checkData:self.passModel];
    if (isExistData) {
        rightBarItem.title = @"Delete";
    }else{
        rightBarItem.title = @"Save";
    }
}

#pragma mark --- get Data from last ViewController . 
-(void)updateload{
    NSMutableArray * annotations = [NSMutableArray array];
    if (self.allmodel.count==0) {
        self.allmodel = [NSArray arrayWithObject:self.passModel];
        rightBarItem.enabled = YES;
        self.title = @"";
    }else{
        rightBarItem.title  = @"";
        rightBarItem.enabled = NO;
        self.title = @"All Results";
    }
        for (DetailModel *dmodel in self.allmodel) {
            MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
            [annotation0 setCoordinate:CLLocationCoordinate2DMake(dmodel.geometry.location.lat, dmodel.geometry.location.lng)];
            [annotation0 setTitle:dmodel.formatted_address];
            [annotation0 setSubtitle:[NSString stringWithFormat:@"%.6f, %.6f",dmodel.geometry.location.lat ,dmodel.geometry.location.lng]];
            [annotations addObject:annotation0];
        }
        [self.mapView addAnnotations:annotations];
    
}

#pragma mark -- Deleagte 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *pinView = ( MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinId];
    if (pinView == nil) {
        pinView  = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinId];
    }
    pinView.annotation = annotation;
    pinView.canShowCallout = YES;
    pinView.pinTintColor = MKPinAnnotationView.redPinColor;
    pinView.animatesDrop = YES;
    return pinView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    MKPointAnnotation *annotation0 = (MKPointAnnotation *)view.annotation;
   
}

#pragma mark --- lazy
-(MKMapView *)mapView{
    if(!_mapView){
        _mapView = [[MKMapView alloc] init];
        _mapView.frame = [UIScreen mainScreen].bounds;
        _mapView.zoomEnabled = YES;
        _mapView.delegate = self;
    }
    return _mapView;
}
-(CoreDataOperation *)operationData{
    if(!_operationData){
        _operationData = [[CoreDataOperation alloc] init];
        [_operationData initWithappDelegate];
    }
    return _operationData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
