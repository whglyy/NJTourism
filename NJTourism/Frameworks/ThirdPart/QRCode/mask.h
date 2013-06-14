//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#ifndef __MASK_H__
#define __MASK_H__
#include "qrinput.h"
extern unsigned char *Mask_makeMask(int width, unsigned char *frame, int mask, QRecLevel level);
extern unsigned char *Mask_mask(int width, unsigned char *frame, QRecLevel level);
#endif /* __MASK_H__ */
