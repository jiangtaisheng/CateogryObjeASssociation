//
//  PersonClass+StudentClass.m
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import "PersonClass+StudentClass.h"
#import <objc/runtime.h>

@implementation PersonClass (StudentClass)

-(void)setAge:(int)age{
    objc_AssociationPolicy policy =OBJC_ASSOCIATION_ASSIGN;
    objc_setAssociatedObject(self, @selector(age), @(age), policy);
    
}
-(int)age{
    //_cmd=@selector(age)
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

-(void)setLove:(NSString *)love
{
    
    objc_AssociationPolicy policy =OBJC_ASSOCIATION_COPY_NONATOMIC;
    objc_setAssociatedObject(self, @selector(love), love, policy);
}

-(NSString *)love{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setHeight:(CGFloat)height{
    objc_AssociationPolicy policy =OBJC_ASSOCIATION_ASSIGN;
    objc_setAssociatedObject(self, @selector(height), @(height), policy);
}

-(CGFloat)height{
    return [objc_getAssociatedObject(self,_cmd) floatValue];
}

@end
