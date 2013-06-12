//
//  Config.m
//  
//
//  Created by     on 2010-4-18
//  Email:   --- at--- gmail.com
//  MSN:     --- at--- tom.com
//  Web Home:       
//  Copyright 2010   .All rights reserved.
//


#import "NSString+SEL.h"

@implementation Config

@synthesize defaults;
@dynamic uid;
@dynamic userId;

@dynamic password;
@dynamic savePassword;

@dynamic mySettingsDTO;

@dynamic everLaunched;
@dynamic firstLaunch;

@dynamic currentFilesCount;
@dynamic haveSettedBoxPwd;
@dynamic lastUserId;
@dynamic autoLogin;
@dynamic isUpdate;
@dynamic versionUpdateCancel;

@dynamic isChatInfoChanged;

-(id) init {
	
    if(!(self = [super init]))
        return self;
	
    self.defaults = [NSUserDefaults standardUserDefaults];
	
    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInt:-1],    dUID,
                                     @"",                            dUserId,
                                     @"",                            dPassword,
                                     [NSNumber numberWithBool:YES],  dSavePassword,
                                     nil,                            dMySettingsDTO,
                                     [NSNumber numberWithBool:NO],   dEverLaunched,
                                     [NSNumber numberWithBool:YES],  dFirstLaunch,
                                     [NSNumber numberWithInt:0],     dCurrentFilesCount,
                                     [NSNumber numberWithBool: NO],  dHaveSettedBoxPwd,
                                     @"",                            dLastUserId,
                                     [NSNumber numberWithBool:NO],   dAutoLogin,
                                     @"0",                           dVersionUpdateCancel,
                                     [NSNumber numberWithInt:AddNewChatRecord2ChatRecordListType],     dIsChatInfoChanged,
                                     nil]];
    
	return self;
}

-(void) dealloc
{
    self.defaults = nil;
	self.uid = nil;
	self.userId = nil;
	self.password = nil;
	self.savePassword = nil;
    self.mySettingsDTO = nil;
    self.everLaunched = nil;
    self.firstLaunch = nil;
    self.currentFilesCount = nil;
    self.haveSettedBoxPwd = nil;
    self.lastUserId = nil;
    self.versionUpdateCancel = nil;
    self.isChatInfoChanged = nil;
}



+(Config *) currentConfig {
    
    static Config *instance;
	
    if(!instance)
		
        instance = [[Config alloc] init];
    
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	    
    if ([NSStringFromSelector(aSelector) hasPrefix:@"set"]){
		
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	}
    //DLog(@"methodSignatureForSelector 2\n");
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSString *selector = NSStringFromSelector(anInvocation.selector);
    if ([selector hasPrefix:@"set"]) {
        NSRange firstChar, rest;
        firstChar.location  = 3;
        firstChar.length    = 1;
        rest.location       = 4;
        rest.length         = selector.length - 5;
        
        selector = [NSString stringWithFormat:@"%@%@",
                    [[selector substringWithRange:firstChar] lowercaseString],
                    [selector substringWithRange:rest]];
        
        id value;
        [anInvocation getArgument:&value atIndex:2];
		
		//DLog(@"forwardInvocation 1\n");
        
        if ([value isKindOfClass:[NSArray class]]) 
        {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:selector];
        }
        else
        {
            [self.defaults setObject:value forKey:selector];
        }
    }
    
    else {
		//DLog(@"forwardInvocation 2\n");
        id value = [self.defaults objectForKey:selector];
        
        if ([value isKindOfClass:[NSData class]]) 
        {
            value = [NSKeyedUnarchiver unarchiveObjectWithData:value];
        }
        [anInvocation setReturnValue:&value];
        
    }
}



@end