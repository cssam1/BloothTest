//
//  ViewController.h
//  BloothTest
//
//  Created by ting on 14-12-1.
//  Copyright (c) 2014年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol id<CBCentralManagerDelegate>;

@end

@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>{

    CBPeripheral *didDiscoverPeripheral;
    CBCentralManager *centralManager;
}



@end

