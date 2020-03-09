//
//  ViewController.m
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import "ViewController.h"
#import "PersonClass+StudentClass.h"
#import "PersonClass.h"
#import "FileMangerClass.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

  
//    PersonClass * class=[[PersonClass alloc]init];
//    class.name=@"jts";
//    class.weight=63;
//    class.sex=@"man";
//    class.age=27;
//    class.height=165;
//    class.love=@"Beauty";
//    NSLog(@"%@---%0.f---%d--%0.f---%@",class.name,class.weight,class.age,class.height,class.love);

    PersonClass * class=[[PersonClass alloc]init];
    [class test:@"Beauty"];
    class.name=@"jts";
    class.weight=63;
    class.sex=@"man";
    class.age=27;
    class.height=165;
    class->coco=@"iii";
//    
//    PersonClass * class2=[[PersonClass alloc]init];
//    [class2 test:@"Beat"];
//    class2.name=@"jts2";
//    class2.weight=63;
//    class2.sex=@"man2";
//    class2.age=27;
//    class2.height=165;
//    class2->coco=@"iii2";
//    
//    //runtime 访问私有成员变量
//    Ivar ivar = class_getInstanceVariable([PersonClass class], "time");
//    NSString * time = object_getIvar(class, ivar);
//    Ivar ivar2 = class_getInstanceVariable([PersonClass class], "_gotime");
//    NSString * gotime = object_getIvar(class, ivar2);
//    [class2 setValue:@"xcxc" forKey:@"_gotime"];
//    NSString * gotime2 = object_getIvar(class2, ivar2);
//    NSLog(@"-------%@--%@",gotime,gotime2);
//
//    
    
    [class getivars];
    NSLog(@"------%@---",class);
    [class getMethodsClass:[class class]];
    printf("-------------------------\n");
    /*获取元类对象：
        1.object_getClass([class class])  object_getClass(类对象）
        2.objc_getMetaClass("PersonClass") objc_getMetaClass(类名)
     */
//    [class getMethodsClass:object_getClass([class class])];
    [class getMethodsClass:objc_getMetaClass("PersonClass")];

    //
}






@end
