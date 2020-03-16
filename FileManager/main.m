//
/*
 ********************************************************************************
 * File     : main.m
 *
 * Author   : chenqg
 *
 * History  : Created by chenqg on 2020/3/16.
 ********************************************************************************
 */

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
