//
/*
 ********************************************************************************
 * File     : NSFileManager+Extention.m
 *
 * Author   : chenqg
 *
 * History  : Created by chenqg on 2020/3/16.
 ********************************************************************************
 */

#import "NSFileManager+Extention.h"

#define PrefixFilemanager @"AppFilePath"

@implementation NSFileManager (Extention)

+ (BOOL)setObject:(id)object forKey:(NSString *)key {
    return [self setObject:object forKey:key directory:DirectoryDefault];
}

+ (BOOL)setObject:(id)object forKey:(NSString *)key directory:(Directory)directory {
    if (object && key && [key isKindOfClass:[NSString class]]) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *filedir = [self filePathForKey:nil directory:directory];
        //先检查目录是否存在,创建目录,最后创建文件
        BOOL isDir = NO;
        BOOL existed = [fileManager fileExistsAtPath:filedir isDirectory:&isDir];
        if (!(isDir == YES && existed == YES) ) {
            [fileManager createDirectoryAtPath:filedir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *real = [NSString stringWithFormat:@"%@_%@",PrefixFilemanager,key];
        NSString *filePath = [filedir stringByAppendingPathComponent:real];
        NSData *saveSource = [NSKeyedArchiver archivedDataWithRootObject:object];
        return [fileManager createFileAtPath:filePath contents:saveSource attributes:nil];
    }
    return NO;
}

+ (id)objectForKey:(NSString *)key {
    return [self objectForKey:key directory:DirectoryDefault];
}

+ (id)objectForKey:(NSString *)key directory:(Directory)directory {
    if (key && [key isKindOfClass:[NSString class]]) {
        NSString *filePath = [self filePathForKey:key directory:directory];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSData *dataSource = [fileManager contentsAtPath:filePath];
        if (dataSource){
            return [NSKeyedUnarchiver unarchiveObjectWithData:dataSource];
        }
    }
    return nil;
}

+ (BOOL)removeObjectForKey:(NSString *)key {
    return [self removeObjectForKey:key directory:DirectoryDefault];
}

+ (BOOL)removeObjectForKey:(NSString *)key directory:(Directory)directory {
    if (key && [key isKindOfClass:[NSString class]]) {
        NSString *filePath = [self filePathForKey:key directory:directory];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

+ (void)removeDirectory:(Directory)directory {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *folderPath = [self filePathForKey:nil directory:directory];
    NSArray *arr = [fileManager contentsOfDirectoryAtPath:folderPath error:nil];
    for (NSString *file in arr) {
        if ([file hasPrefix:PrefixFilemanager]) {
            NSError *err = nil;
            NSString *removePath = [folderPath stringByAppendingPathComponent:file];
            [fileManager removeItemAtPath:removePath error:&err];
        }
    }
}

+ (NSString *)filePath:(NSString *)name directory:(Directory)directory{
    return [self filePathForKey:name directory:directory];
}

+ (void)removeAllData {
    [self removeDirectory:DirectoryDefault];
    [self removeDirectory:DirectoryDocuments];
    [self removeDirectory:DirectoryLibrary];
    [self removeDirectory:DirectoryLibraryCaches];
    [self removeDirectory:DirectoryTmp];
}

+ (NSString *)getDocumentFilePath:(NSString*)strName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",PrefixFilemanager,strName];
        return [documentsDirectory stringByAppendingPathComponent:name];
    }
    return documentsDirectory;
}

+ (NSString *)getLibraryFilePath:(NSString *)strName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *library = [paths objectAtIndex:0];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",PrefixFilemanager,strName];
        return [library stringByAppendingPathComponent:name];
    }
    return library;
}

+ (NSString *)getLibraryCacheFilePath:(NSString *)strName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cache = [paths objectAtIndex:0];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",PrefixFilemanager,strName];
        return [cache stringByAppendingPathComponent:name];
    }
    return cache;
}

+ (NSString *)getTmpFilePath:(NSString *)strName {
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",PrefixFilemanager,strName];
        return [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    }
    return NSTemporaryDirectory();
}

+ (NSString *)getDefaultFilePath:(NSString *)strName {
    NSString *temp = NSTemporaryDirectory();
    NSString *subDir = [temp stringByAppendingPathComponent:@"defaultFiles"];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",PrefixFilemanager,strName];
        return [subDir stringByAppendingPathComponent:name];
    }
    return subDir;
}

+ (NSString *)filePathForKey:(NSString *)key directory:(Directory)directory {
    NSString *filePath = nil;
    switch (directory) {
        case DirectoryDocuments:
            filePath = [self getDocumentFilePath:key];
            break;
        case DirectoryLibrary:
            filePath = [self getLibraryFilePath:key];
            break;
        case DirectoryLibraryCaches:
            filePath = [self getLibraryCacheFilePath:key];
            break;
        case DirectoryTmp:
            filePath = [self getTmpFilePath:key];
            break;
        case DirectoryDefault:
            filePath = [self getDefaultFilePath:key];
            break;
        default:
            break;
    }
    return filePath;
}

@end

