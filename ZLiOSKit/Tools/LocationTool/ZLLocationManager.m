//
//  ZLLocationManager.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/9.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ZLLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) LocationInfoBlock completeBlock;

@end

@implementation ZLLocationManager

+ (instancetype)shareManager {
    static ZLLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZLLocationManager alloc] init];
        CLLocationManager *locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = manager;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 200;
        manager.locationManager = locationManager;
    });
    return manager;
}

- (void)registerLocationService {
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

///开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
}

///结束定位
- (void)stopLocation {
    [self.locationManager stopUpdatingLocation];
}

///定位失败回调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

/*
 country 国家
 administrativeArea 省
 locality 市
 subLocality 区
 thoroughfare 街道
 subThoroughfare 门牌号
 name 具体位置
 */


//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            if (self.completeBlock) {
                CLPlacemark *placemark = [array objectAtIndex:0];
                NSMutableString *resultString = [NSMutableString string];
                NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
                if (placemark.administrativeArea) {
                    [resultString appendString:placemark.administrativeArea];
                    [resultDict setValue:placemark.administrativeArea forKey:@"province"];
                }
                if (placemark.locality) {
                    [resultString appendString:placemark.locality];
                    [resultDict setValue:placemark.locality forKey:@"city"];
                }
                if (placemark.subLocality) {
                    [resultString appendString:placemark.subLocality];
                    [resultDict setValue:placemark.subLocality forKey:@"area"];
                }
                if (placemark.name) {
                    [resultString appendString:placemark.name];
                    [resultDict setValue:placemark.name forKey:@"name"];
                }
                self.completeBlock(resultString, resultDict);
                self.completeBlock = nil;
            }
        }
        else if (error == nil && [array count] == 0) {
            
        }
        else if (error != nil) {
            
        }
    }];
    [self stopLocation];
}

- (void)getCurrentLocationInfo:(LocationInfoBlock)complete {
    self.completeBlock = complete;
    [self startLocation];
}

@end
