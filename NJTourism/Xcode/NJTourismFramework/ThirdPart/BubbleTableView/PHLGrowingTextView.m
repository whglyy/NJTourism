//
//  PHLGrowingTextView.m
//  Growing UITextView
//
//  Created by namanhams on 29/10/12.
//  Copyright (c) 2012 namanhams. All rights reserved.
//

#import "PHLGrowingTextView.h"

@interface PHLGrowingTextView () {
    BOOL _isAnimating;
}

@end


@implementation PHLGrowingTextView

@synthesize delegate, minHeight, maxHeight, backgroundImage, adjustVerticalPosititon;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self initialize];
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self initialize];
    
    return self;
}

- (void) initialize {
    self.maxHeight = MAXFLOAT;
    self.minHeight = 0;
    self.backgroundColor = [UIColor clearColor];
    self.backgroundImage = [[UIImage imageNamed:@"textbox.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(13, 13, 12, 12)];
    self.adjustVerticalPosititon = YES;
    
    [self addObserver:self
           forKeyPath:@"frame"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
    
    [self addObserver:self
           forKeyPath:@"contentSize"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

- (void) dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (void) setBackgroundImage:(UIImage *)image {
    backgroundImage = image;
    
    [self setNeedsDisplay];
}

- (void) setMaxHeight:(CGFloat)value {
    maxHeight = value;
    
    if(self.frame.size.height > value) {
        CGRect frame = self.frame;
        frame.size.height = value;
        self.frame = frame;
    }
}

- (void) setMinHeight:(CGFloat)value {
    minHeight = value;
    
    if(self.frame.size.height < value) {
        CGRect frame = self.frame;
        frame.size.height = value;
        self.frame = frame;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        
        CGFloat oldContentHeight = [[change valueForKey:@"old"] CGSizeValue].height;
        CGFloat newContentHeight = [[change valueForKey:@"new"] CGSizeValue].height;
        
        if(oldContentHeight != newContentHeight) {
            
            CGFloat expectedHeight = newContentHeight;
            if(expectedHeight > self.maxHeight)
                expectedHeight = self.maxHeight;
            if(expectedHeight < self.minHeight)
                expectedHeight = self.minHeight;
            
            if([self.delegate respondsToSelector:@selector(textView:willChangeToHeight:)])
                [self.delegate textView:self willChangeToHeight:expectedHeight];
            
            CGFloat oldHeight = self.frame.size.height;
            
            [UIView animateWithDuration:0.1
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 
                                 _isAnimating = TRUE;
                                 
                                 CGRect frame = self.frame;
                                 frame.size.height = expectedHeight;
                                 if(self.adjustVerticalPosititon) {
                                     frame.origin.y += (oldHeight - expectedHeight);
                                 }
                                 self.frame = frame;
                                 
                             } completion:^(BOOL finished) {
                                 _isAnimating = FALSE;
                                 if([self.delegate respondsToSelector:@selector(textView:didChangeFromHeight:)])
                                     [self.delegate textView:self didChangeFromHeight:oldHeight];
                             }];
        }
    }
    else if([keyPath isEqualToString:@"frame"]) {
        if(_isAnimating)
            return;
        CGRect oldFrame = [[change valueForKey:@"old"] CGRectValue];
        CGRect newFrame = [[change valueForKey:@"new"] CGRectValue];
        if(oldFrame.size.height != newFrame.size.height) {
            if([self.delegate respondsToSelector:@selector(textView:didChangeFromHeight:)])
                [self.delegate textView:self didChangeFromHeight:oldFrame.size.height];
        }
    }
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGRect frame = CGRectInset(self.bounds, 0, -1);
    [self.backgroundImage drawInRect:frame];
}

@end