//
//  TextLayoutLabel.h
//  FatFist
//
//  Created by lyywhg on 12-5-1.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextLayoutLabel : UILabel

{
    
@private
    
    CGFloat characterSpacing_;       //字间距
    
    long linesSpacing_;   //行间距
    
}

@property (nonatomic, assign)CGFloat characterSpacing;

@property (nonatomic, assign)long linesSpacing;

@end
