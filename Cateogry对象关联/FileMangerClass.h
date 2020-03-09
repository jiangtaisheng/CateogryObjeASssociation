//
//  FileMangerClass.h
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileMangerClass : NSObject
// 判断文件是否存在
+(BOOL)isFileNameExist:(NSString *)filePath;

//判断一个文件是文件还是文件夹
+ (BOOL)isexistFileFolder:(NSString *)path;

//根据文件路径截取文件名字（不包含后缀名）
+(NSString *)getPathExtensionName:(NSString *)path;

//根据文件路径截取文件名字（包含后缀名）
+(NSString *)getlastPathComponentPath:(NSString *)path;

//获取文件大小
+ (long long)getFileSizeWithPath:(NSString *)path;

//获取文件创建时间
+ (NSString *)getFileCreatDateWithPath:(NSString *)path;

//获取文件所有者
+ (NSString *)getFileOwnerWithPath:(NSString *)path;

//获取文件更改日期
+ (NSString *)getFileChangeDateWithPath:(NSString *)path;

//获取(递归所有目录）文件夹下所有文件 遍历
+(NSMutableArray *)getAllDirInFileDir:(NSString *)fileDir;

//获取(只包括一级目录，不递归)所有文件夹 的绝对路径
+ (NSArray *)obtianAllFileFolder:(NSString *)path;

//获取(只包括一级目录，不递归)所有文件
+ (NSMutableArray *)achevieAllFileFolder:(NSString *)path;

//获取(只包括一级目录，不递归)所有文件夹 拼接成字符串
+( NSString*)achevieAllFileFolderString:(NSString *)path;

//从文件夹下所有的（只包括一级目录，不递归）获取【带】（后缀）的文件  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getfileInFileDir:(NSString *)fileDir suffixString:(NSString *)suffix;

//从文件夹下所有的（只包括一级目录，不递归）获取【不带】（后缀）的文件  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getfileInFileDir:(NSString *)fileDir notSuffixString:(NSString *)suffix;

//(递归所有目录）获取【带】（后缀）的文件  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getAllFileInFileDir:(NSString *)fileDir suffixString:(NSString *)suffix;


//(递归所有目录） 获取【不带】（后缀）的文件 此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getAllFileInFileDir:(NSString *)fileDir notSuffixString:(NSString *)suffix;

@end

NS_ASSUME_NONNULL_END
