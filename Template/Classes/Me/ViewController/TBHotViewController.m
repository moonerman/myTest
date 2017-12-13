

//
//  TBHotViewController.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/19.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBHotViewController.h"

@interface TBHotViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate>

@property(nonatomic,strong)BMKMapView* mapView ;
@property(nonatomic,strong)BMKLocationService *locService;
//@property(nonatomic,strong)BMKGeoCodeSearch *geocodesearch;


@end

@implementation TBHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64)];
    self.view = _mapView;
    _mapView.zoomEnabled = YES;
    _mapView.isSelectedAnnotationViewFront = YES;//设定是否总让选中的annotaion置于最前面

    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.distanceFilter = 0.001;//指定定位的最小更新距离(米)

//    _locService.delegate = self;
    _locService.allowsBackgroundLocationUpdates = YES;
    //启动LocationService    
    
    
}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    // [_mapView updateLocationData:userLocation];
    
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        
    }
    
    [_mapView setZoomLevel:19.0];
    
    [_locService stopUserLocationService];//定位完成停止位置更新
    
//    //添加当前位置的标注
//    CLLocationCoordinate2D coord;
//    coord.latitude = userLocation.location.coordinate.latitude;
//    coord.longitude = userLocation.location.coordinate.longitude;
//    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
//    _pointAnnotation.coordinate = coord;
//    _pointAnnotation.title = @"我的";
//    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
//    pt=(CLLocationCoordinate2D){coord.latitude,coord.longitude};
//    
//    
//    
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_mapView removeOverlays:_mapView.overlays];
//        [_mapView setCenterCoordinate:coord animated:true];
//        [_mapView addAnnotation:_pointAnnotation];
//        
//    });
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placeMark = [array objectAtIndex:0];
            if (placeMark != nil) {
                NSString *city = placeMark.locality;
                NSString *name = [NSString stringWithFormat:@"%@%@%@%@%@",placeMark.country,city,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
                ZLog(@"当前城市名称------%@",name);
             //   _pointAnnotation.title = name;
                //                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                //              //  _offlineMap.delegate = self;//可以不要
                //                NSArray* records = [_offlineMap searchCity:city];
                //                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //                //城市编码如:北京为131
                //                NSInteger cityId = oneRecord.cityID;
                //                NSString *cityName = oneRecord.cityName;
                //                ZLog(@"当前城市编号-------->%zd--------%@======%@",cityId,cityName,oneRecord);
                //找到了当前位置城市后就关闭服务
                [_locService stopUserLocationService];
                
            }
        }
    }];
    
    ZLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;//移动到中心点

    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        
    }
    _mapView.zoomLevel= 16.0;

        //添加当前位置的标注
    CLLocationCoordinate2D coord;
    coord.latitude = userLocation.location.coordinate.latitude;
    coord.longitude = userLocation.location.coordinate.longitude;
    
//    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
//    _pointAnnotation.coordinate = coord;
//    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
//    pt=(CLLocationCoordinate2D){coord.latitude,coord.longitude};
//    
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_mapView removeOverlays:_mapView.overlays];
//        [_mapView setCenterCoordinate:coord animated:true]; 
//        [_mapView addAnnotation:_pointAnnotation];
//        
//    });
//
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placeMark = [array objectAtIndex:0];
            if (placeMark != nil) {
                NSString *city = placeMark.locality;
                NSString *name = [NSString stringWithFormat:@"%@%@%@%@%@",placeMark.country,city,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
                ZLog(@"当前位置名称------%@",name);

             //   _pointAnnotation.title = name;
               
//                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
//              //  _offlineMap.delegate = self;//可以不要
//                NSArray* records = [_offlineMap searchCity:city];
//                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
//                //城市编码如:北京为131
//                NSInteger cityId = oneRecord.cityID;
//                NSString *cityName = oneRecord.cityName;
//                ZLog(@"当前城市编号-------->%zd--------%@======%@",cityId,cityName,oneRecord);
                //找到了当前位置城市后就关闭服务
            //    [_locService stopUserLocationService];
                
            }
        }
    }];
    
    ZLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}



-(void)didFailToLocateUserWithError:(NSError *)error{
    ZLog(@"%@",error);
}

-(void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{
    
    ZLog(@"点击");
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = mapPoi.pt;
    annotation.title = mapPoi.text;
    [_mapView addAnnotation:annotation];
}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{

    ZLog(@"---%@------",view.annotation.title);
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _locService.delegate = self;
    [_locService startUserLocationService];
   // _mapView.zoomLevel=21.0;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _locService.delegate = nil; // 不用时，置nil
    [_locService stopUserLocationService];
    _mapView.delegate = nil;
}
@end
