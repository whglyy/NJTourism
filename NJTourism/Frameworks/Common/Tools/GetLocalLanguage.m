//
//  GetLocalLanguage.m
//  NJTourism
//
//  Created by lyywhg on 13-6-16.
//
//

#import "GetLocalLanguage.h"

@implementation GetLocalLanguage

+ (NSInteger)getLocalLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    if ([currentLanguage isEqualToString:@"zh-Hans"])
    {
        return IsChineseType;
    }
    else if ([currentLanguage isEqualToString:@"en"])
    {
        return IsEnglishType;
    }
    else if ([currentLanguage isEqualToString:@"ko"])
    {
        return IsKoreaType;
    }
    else if ([currentLanguage isEqualToString:@"ja"])
    {
        return IsJanpaneseType;
    }
    return IsOtherType;
}

@end
