//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "DefineConstant.h"


extern NSString* EncodeObjectFromDic(NSDictionary *dic, NSString *key)
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    NSString *value = @"";
    if (NotNilAndNull(temp))   {
        if ([temp isKindOfClass:[NSString class]]) {
             value = temp;
        }else if([temp isKindOfClass:[NSNumber class]]){
            value = [temp stringValue];
        }
        return value;
    }
    return nil;
}


extern SNPageInfo
SNPageInfoMake(NSInteger currentPage, NSInteger totalPage, NSInteger pageSize)
{
    return (SNPageInfo){currentPage, totalPage, pageSize};
}

const SNPageInfo SNPageInfoZero = {0,0,0};
