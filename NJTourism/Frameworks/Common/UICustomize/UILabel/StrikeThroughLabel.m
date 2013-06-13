//
//  StrikeThroughLabel.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "StrikeThroughLabel.h"

@implementation StrikeThroughLabel
@synthesize isWithStrikeThrough = isWithStrikeThrough_;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.isWithStrikeThrough = YES;
        
        if (!line_)
        {
            line_ = [[UIImageView alloc] init];
            
            line_.frame = CGRectZero;
            
            [self addSubview:line_];
        }
    }
    return self;
}



- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (isWithStrikeThrough_) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //设置颜色
        UIColor *textColor = self.textColor;
        CGContextSetStrokeColorWithColor(context, textColor.CGColor);
        
        //设置线宽
        CGContextSetLineWidth(context, 1);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        //画线
        CGContextMoveToPoint(context, 0, self.size.height/2);
        CGSize wordSize = [self.text sizeWithFont:self.font
                                constrainedToSize:self.size
                                    lineBreakMode:UILineBreakModeCharacterWrap];
        CGContextAddLineToPoint(context, wordSize.width, self.size.height/2);
        CGContextStrokePath(context);
    }
    
}

@end
