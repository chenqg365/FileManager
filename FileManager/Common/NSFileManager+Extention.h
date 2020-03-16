//
/*
 ********************************************************************************
 * File     : NSFileManager+Extention.h
 *
 * Author   : chenqg
 *
 * History  : Created by chenqg on 2020/3/16.
 ********************************************************************************
 */


#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, Directory) {
    DirectoryDefault       = 0, // Library/Caches/defaultFiles
    DirectoryDocuments     = 1, // Documents (理论上永不删除)
    DirectoryLibrary       = 2, // Library (理论上永不删除)
    DirectoryLibraryCaches = 3, // Library/Caches
    DirectoryTmp           = 6  // tmp
};

@interface NSFileManager (Extention)

+ (BOOL)setObject:(id)object forKey:(NSString *)key;
//保存某个数据
+ (BOOL)setObject:(id)object forKey:(NSString *)key directory:(Directory)directory;

//获取某个数据
+ (id)objectForKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key directory:(Directory)directory;

//删除某个数据
+ (BOOL)removeObjectForKey:(NSString *)key;
+ (BOOL)removeObjectForKey:(NSString *)key directory:(Directory)directory;

//删除某个目录
+ (void)removeDirectory:(Directory)directory;
//删除所有数据
+ (void)removeAllData;
//获取文件路径
+ (NSString *)filePath:(NSString *)key directory:(Directory)directory;

@end
