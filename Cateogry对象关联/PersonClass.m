//
//  PersonClass.m
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonClass.h"
#import <objc/runtime.h>
@interface PersonClass ()<NSCoding>
{
    NSString *  time;

}
@property (copy, nonatomic) NSString *prite;
@property (copy, nonatomic) NSString *gotime;

@end

@implementation PersonClass

+(void)helpClass{
    
    
}

-(instancetype)init{
    if (self=[super init]) {
       time=@"mmmmm";
    }
    return self;
}

-(void)test:(NSString *)gotime{
    self.gotime=gotime;
    
}
+(void)get:(NSArray *)data open:(NSString *)uu{
    
}

-(void)setdatwaa{
    
}

-(BOOL)isEqual:(id)object{
    if (self==object) {
        return YES;
    }
    
    if (object&&[object isMemberOfClass:[self class]]) {
        PersonClass * class=object;
        BOOL ret=YES;
        ret=ret &&[self.name isEqualToString:class.name];
        ret=ret &&[self.sex isEqualToString:class.sex];
        ret=ret &&(self.weight==class.weight);
        return ret;
    }
    return NO;
}

//使用runtime 实现keyVaule 的赋值 重写 -(instancetype)initWithCoder:(NSCoder *)aDecoder
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        unsigned int outCount;
        objc_property_t * properties = class_copyPropertyList([self class], &outCount);
        for (int i=0; i<outCount; i++) {
            objc_property_t  property = properties[i];
            const char * char_f= property_getName(property);
            NSString * keyName=[NSString stringWithFormat:@"%s",char_f];
            NSLog(@"----keyName:%@",keyName);
            [self setValue:[aDecoder decodeObjectForKey:keyName] forKey:keyName];
        }
        free(properties);
    }
    return self;
}

//使用runtime 实现keyVaule 的赋值  重写 -(void)encodeWithCoder:(NSCoder *)aCoder
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t  property = properties[i];
        const char * char_f= property_getName(property);
        NSString * keyName=[NSString stringWithFormat:@"%s",char_f];
        NSLog(@"----keyName:%@",keyName);
        [aCoder encodeObject:[self valueForKey:keyName] forKey:keyName];
    }
    
    free(properties);

}


//获取属性值
-(void)getProperties{
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t  property = properties[i];
        const char * char_f= property_getName(property);
        NSString * propertyName=[NSString stringWithFormat:@"%s",char_f];

        NSLog(@"----propertyNmae:%@",propertyName);

    }
    
    free(properties);

}


//获取成员变量-------
-(void)getivars{
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
         Ivar  ivar = ivars[i];
        const char * char_f= ivar_getName(ivar);
        NSString * ivarName=[NSString stringWithFormat:@"%s",char_f];
        NSString * type= [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        NSLog(@"--- 成员变量的类型-----%@---",type);
        id value;
        if ([type isEqualToString:@"d"]) {
            value = [self valueForKey:ivarName];
            NSLog(@"=====%@",value);
        }else{
           value=object_getIvar(self, ivar);
        }
        if (!value) {
            object_setIvar(self, ivar, @"bbbbb");
            value=object_getIvar(self, ivar);
        }else if ([ivarName isEqualToString:@"time"]){
            [self setValue:@"timechengyuan" forKey:ivarName];
            value = [self valueForKey:ivarName];

        }
        NSLog(@"----ivarName:%@  : %@",ivarName,value);
    }
    
    free(ivars);

}


-(void)getMethodsClass:(Class)class{
    unsigned int outCount;
    
    Method * methods=class_copyMethodList(class, &outCount);
    for (int i=0; i<outCount; i++) {
        Method  method =methods[i];
        SEL sel= method_getName(method);
        const char * selName = sel_getName(sel);
        NSString * methodName=[NSString stringWithFormat:@"%s",selName];
        NSLog(@"=====%@",methodName);
    }
    
    free(methods);
}

//使用runtime 实现keyVaule 的赋值  重写 description
- (NSDictionary *)runTimeKeyValues
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSDictionary *values;
    NSDictionary *propertyNames;
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue;
        if (values[propertyName]) {
            propertyValue=values[propertyName];
        }else{
            propertyValue= [self valueForKey:(NSString *)propertyName];
        }
        if (propertyNames[propertyName]) {
            propertyName=propertyNames[propertyName];
        }
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return props;
}



-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self runTimeKeyValues]];
}



//动态添加方法


@end
