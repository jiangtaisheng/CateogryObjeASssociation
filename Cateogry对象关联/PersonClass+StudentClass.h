//
//  PersonClass+StudentClass.h
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import "PersonClass.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PersonClass (StudentClass)
@property(nonatomic,assign) CGFloat   height  ;
@property(nonatomic,assign) int   age  ;
@property(nonatomic,copy) NSString * love ;
@end

NS_ASSUME_NONNULL_END
