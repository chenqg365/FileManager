//
/*
 ********************************************************************************
 * File     : ViewController.m
 *
 * Author   : chenqg
 *
 * History  : Created by chenqg on 2020/3/16.
 ********************************************************************************
 */

#import "ViewController.h"
#import "NSFileManager+Extention.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *infor = @{@"name":@"jack",@"age":@"18",@"money":@(9999999.99)};
    BOOL success = [NSFileManager setObject:infor forKey:@"infor"];
    if (success) {
        id model = [NSFileManager objectForKey:@"infor"];
        NSLog(@"model -- > %@",model);
    }
}


@end
