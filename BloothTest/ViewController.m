//
//  ViewController.m
//  BloothTest
//
//  Created by ting on 14-12-1.
//  Copyright (c) 2014年 yuanbo. All rights reserved.
//

#import "ViewController.h"
#import "AlertUtil.h"


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CBCentralManager *manager;
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [manager scanForPeripheralsWithServices:nil options:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)centralManagerDidUpdateState:(CBCentralManager *)central{

}

//搜索成功
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    didDiscoverPeripheral = peripheral;
    for(CBCharacteristic *characteristic in didDiscoverPeripheral.services){
        [AlertUtil showMsg:characteristic.description];
    }
//    if(![didDiscoverPeripheral containsObject:peripheral]){
//        [didDiscoverPeripheral addObject:peripheral];
//    }
}

//搜索失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    centralManager = central;
    didDiscoverPeripheral = peripheral;
    NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
    [AlertUtil showMsg:[error localizedDescription]];
    [self cleanup];
}

//清除连接
- (void)cleanup
{
    // Don't do anything if we're not connected
    if (!didDiscoverPeripheral.isConnected) {
        return;
    }
    
    // See if we are subscribed to a characteristic on the peripheral
    if (didDiscoverPeripheral.services != nil) {
        for (CBService *service in didDiscoverPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if (characteristic.isNotifying) {
                        // It is notifying, so unsubscribe
                        [didDiscoverPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                        // And we're done.
                        return;
                    } 
                } 
            } 
        } 
    }
    
    // If we've got this far, we're connected, but we're not subscribed, so we just disconnect 
    [centralManager cancelPeripheralConnection:didDiscoverPeripheral];
}
//
////连接指定的设备
//-(BOOL)connect:(CBPeripheral *)peripheral
//{
//    NSLog(@"connect start");
//    _testPeripheral = nil;
//    
//    [manager connectPeripheral:peripheral
//                       options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
//    
//    //开一个定时器监控连接超时的情况
//    connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(connectTimeout:) userInfo:peripheral repeats:NO];
//    
//    return (YES);
//}

@end

