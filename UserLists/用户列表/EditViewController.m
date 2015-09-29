//
//  EditViewController.m
//  用户列表
//
//  Created by hyrMac on 15/8/15.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "EditViewController.h"
#import "EGODatabase.h"
#import <CoreData/CoreData.h>
#import "User.h"

@interface EditViewController ()
{
    NSManagedObjectContext *context;
}

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationItem.title = @"编辑";
    [self openDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openDB {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedModel];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/datahyr.sqlite"];
    NSLog(@"%@",filePath);
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileUrl options:nil error:&error];
    
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = coordinator;
}



- (IBAction)addAction:(id)sender {

    if (_userName.text == nil || _passWord.text == nil || _age.text == nil) {
        NSLog(@"请填写完整");
        return;
    }
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user.userName = _userName.text;
    user.passWord = _passWord.text;
    user.age = _age.text;
    
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"[addAction:]error");
    }

}



@end
