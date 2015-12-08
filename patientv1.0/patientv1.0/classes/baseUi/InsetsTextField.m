//
//  InsetsTextField.m
//  GreenStarTreasure
//
//  Created by define on 14-12-24.
//  Copyright (c) 2014年 zhengjing. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

//控制placeHolder的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

@end
