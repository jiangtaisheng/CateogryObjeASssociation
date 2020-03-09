//
//  FileMangerClass.m
//  Cateogry对象关联
//
//  Created by jiangtaisheng on 2019/5/8.
//  Copyright © 2019 jiangtaisheng. All rights reserved.
//

#import "FileMangerClass.h"

@implementation FileMangerClass

//根据文件路径截取文件名字（不包含后缀名）
+(NSString *)getPathExtensionName:(NSString *)path{
//    NSString * path=@"/var/Xbfile/Deb文件/gamedownloadResrcfile.deb";
    NSString * lastComponent=[path lastPathComponent]; //获取路径的最后一节
    NSString * name=[lastComponent stringByDeletingPathExtension];//获取删除后缀后的路径
    return name;
}

//根据文件路径截取文件名字（包含后缀名）
+(NSString *)getlastPathComponentPath:(NSString *)path{
    //    NSString * path=@"/var/Xbfile/Deb文件/gamedownloadResrcfile.deb";
    NSString * lastComponent=[path lastPathComponent]; //获取路径的最后一节
    return lastComponent;
}

//获取文件大小
+ (long long)getFileSizeWithPath:(NSString *)path
{
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue]; //单位是 B
    }
    return fileLength / 1000;

}

//获取文件创建时间
+ (NSString *)getFileCreatDateWithPath:(NSString *)path
{
    NSString *date = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    date = [fileAttributes objectForKey:NSFileCreationDate];
    return date;
}

//获取文件所有者
+ (NSString *)getFileOwnerWithPath:(NSString *)path
{
    NSString *fileOwner = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    fileOwner = [fileAttributes objectForKey:NSFileOwnerAccountName];
    return fileOwner;
}

//获取文件更改日期
+ (NSString *)getFileChangeDateWithPath:(NSString *)path
{
    NSString *date = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    date = [fileAttributes objectForKey:NSFileModificationDate];
    return date;
}




// 判断文件是否存在
+(BOOL)isFileNameExist:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    } else {
        return NO;
    }
}


//获取(递归所有目录）文件夹下所有文件 遍历
+(NSMutableArray *)getAllDirInFileDir:(NSString *)fileDir {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator;
    enumerator = [fileManager enumeratorAtPath:fileDir];
    NSString* path;
    NSMutableArray *readDataSource=[[NSMutableArray alloc]initWithCapacity:0];
    while((path = [enumerator nextObject]) != nil) {
        //把得到的文件名称添加到数组中
        if (![path isEqualToString:@".DS_Store"]) {
            [readDataSource addObject:path];
        }
    }
    return readDataSource;
}



//判断一个文件是文件还是文件夹
+ (BOOL)isexistFileFolder:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 判断文件是否存在，并且是否为文件夹
    BOOL dir = NO;
    if ([fileManager fileExistsAtPath:path isDirectory:&dir]&&dir==YES)
    {
        return YES;
    }
    return NO;
}

//获取(只包括一级目录，不递归)所有文件夹 的绝对路径
+ (NSArray *)obtianAllFileFolder:(NSString *)path
{
    NSMutableArray * dataArray =[NSMutableArray arrayWithCapacity:0];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray * array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (NSString * filename  in array){
        NSString * filePath  =[NSString stringWithFormat:@"%@/%@",path,filename];
        BOOL isFolder =[self isexistFileFolder:filePath];
        if (isFolder) {
            [dataArray addObject:filePath];
        }
    }
    return dataArray;
}
//获取(只包括一级目录，不递归)所有文件
+ (NSMutableArray *)achevieAllFileFolder:(NSString *)path
{
    NSMutableArray * dataArray =[NSMutableArray arrayWithCapacity:0];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray * array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (NSString * filename  in array){
        [dataArray addObject:filename];
    }
    return dataArray;
}
//获取(只包括一级目录，不递归)所有文件夹 拼接成字符串
+( NSString*)achevieAllFileFolderString:(NSString *)path
{
    NSMutableString * dataString =[[NSMutableString alloc]initWithCapacity:0];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray * array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (int i=0; i<array.count; i++) {
        NSString * filename=array[i];
        NSString* file=nil;
        if ((i==0)&&(i==(array.count-1))){
            file=[NSString stringWithFormat:@"%@",filename];
        }else if ((i==0)&&(i!=(array.count-1))){
            file=[NSString stringWithFormat:@"%@,",filename];
        }else if (i==(array.count-1)){
            file=[NSString stringWithFormat:@"%@",filename];
        }else{
            file=[NSString stringWithFormat:@"%@,",filename];
        }
        [dataString appendString:file];
    }
    return dataString;
}

//从文件夹下所有的（只包括一级目录，不递归）获取带（后缀）的文件  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getfileInFileDir:(NSString *)fileDir suffixString:(NSString *)suffix{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * error=nil;
    NSArray * fileList= [fileManager contentsOfDirectoryAtPath:fileDir error:&error];
    NSMutableArray *readDataSource=[[NSMutableArray alloc]initWithCapacity:0];
    for (NSString * path in fileList) {
        NSString *suff = [path pathExtension];
        if ([suff isEqualToString:suffix]) {
            [readDataSource addObject:path];
        }
    }
    return readDataSource;
}

//从文件夹下所有的（只包括一级目录，不递归）获取带（后缀）的文件  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getfileInFileDir:(NSString *)fileDir notSuffixString:(NSString *)suffix{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * error=nil;
    NSArray * fileList= [fileManager contentsOfDirectoryAtPath:fileDir error:&error];
    NSMutableArray *readDataSource=[[NSMutableArray alloc]initWithCapacity:0];
    for (NSString * path in fileList) {
        NSString *suff = [path pathExtension];
        if ((![path isEqualToString:@".DS_Store"])&&(![suff isEqualToString:suffix])) {
            [readDataSource addObject:path];
        }
    }
    return readDataSource;
}

//(递归所有目录）  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getAllFileInFileDir:(NSString *)fileDir suffixString:(NSString *)suffix{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator;
    enumerator = [fileManager enumeratorAtPath:fileDir];
    NSString* path;
    NSMutableArray *readDataSource=[[NSMutableArray alloc]initWithCapacity:0];
    while((path = [enumerator nextObject]) != nil) {
        NSString *suff = [path pathExtension];
        //NSLog(@"suffgetAllFileInFileDir======%@==%@=",suff,path);
        if ([suff isEqualToString:suffix]) {
            [readDataSource addObject:path];
        }
    }
    return readDataSource;
}

//(递归所有目录）  此处suffix 不用加（.）号。。 例如：（@"png",@"txt"）
+(NSMutableArray *)getAllFileInFileDir:(NSString *)fileDir notSuffixString:(NSString *)suffix{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator;
    enumerator = [fileManager enumeratorAtPath:fileDir];
    NSString* path;
    NSMutableArray *readDataSource=[[NSMutableArray alloc]initWithCapacity:0];
    while((path = [enumerator nextObject]) != nil) {
        NSString *suff = [path pathExtension];
        if ((![path isEqualToString:@".DS_Store"])&&(![suff isEqualToString:suffix])) {
            [readDataSource addObject:path];
        }
    }
    return readDataSource;
}


@end
