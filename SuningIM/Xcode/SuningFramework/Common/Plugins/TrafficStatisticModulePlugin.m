//
//  TrafficStatisticModulePlugin.m
//  SuningPan
//
//  Created by shasha on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//
#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>

#import "TrafficStatisticModulePlugin.h"

@implementation TrafficStatisticModulePlugin

- (id)init
{
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = eTypeTrafficStaticModule;
        self.moduleName = kTrafficStaticModuleName;
    }
    return self;
}

- (id)initWithModuleType:(E_ModuleType)type{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = type;
        self.moduleName = kTrafficStaticModuleName;
    }
    return self;
}

- (id)initWithModuleName:(NSString *)name{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = eTypeTrafficStaticModule;
        self.moduleName = name;
    }
    return self;
}

- (void)excuteWithCompleteBlock:(SNCallBackBlockWithResult)block{
    //Do some excute task
    char cPort[14] = "10.19.163.121";
    long long int totle3GBytes = [self getGprs3GFlowIOBytes:cPort];
    long long int totleWifiBytes = [self getInterfaceBytes:cPort];
    long long int totleBytes = totle3GBytes + totleWifiBytes;
    NSString *totleByteDisc = [NSString bytesToAvaiUnit:totleBytes];
    if (block) {
        block(YES,nil,totleByteDisc);
    }
    //call blocks
}

- (long long int)getFlowIOBytes:(char *)cPort type:(int)iType
{
    if (iType == 1)
    {
        return [self getGprs3GFlowIOBytes:cPort];
    }
    else if (iType == 2)
    {
        return [self getInterfaceBytes:cPort];
    }
    return 0;
}

//获取3G流量
- (long long int) getGprs3GFlowIOBytes:(char *)cPort
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1)
    {
        return 0;
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (ifa->ifa_addr->sa_data != cPort)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        if (!strcmp(ifa->ifa_name, "pdp_ip0"))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
			NSLog(@"%s :iBytes is %d, oBytes is %d",
				  ifa->ifa_name, iBytes, oBytes);
        }
    }
    freeifaddrs(ifa_list);
    
	return iBytes + oBytes;
}

//获取wifi流量
- (long long int)getInterfaceBytes:(char *)cPort
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1)
    {
        return 0;
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (ifa->ifa_addr->sa_data != cPort)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        /* Not a loopback device. */
        if (strncmp(ifa->ifa_name, "lo", 2))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            
                        NSLog(@"%s :iBytes is %d, oBytes is %d",
                              ifa->ifa_name, iBytes, oBytes);
        }
    }
    freeifaddrs(ifa_list);
    
    return iBytes+oBytes;
}

@end
