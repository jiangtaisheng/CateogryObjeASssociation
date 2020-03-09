//
//  PersonClass.h
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PersonClass : NSObject
{
    @public NSString * coco;
//    NSString * coco;
    NSArray * arr;
    int  no;
    
    
}
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;
@property(nonatomic,assign) CGFloat   weight  ;
//@property (copy, nonatomic) NSString *weight;

+(void)helpClass;
-(void)getProperties;
-(void)getivars;
-(void)test:(NSString *)gotime;
//-(void)getMethods;
-(void)getMethodsClass:(Class )class;
@end

NS_ASSUME_NONNULL_END
