//
//  ViewController.m
//  用户列表
//
//  Created by hyrMac on 15/8/15.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ViewController.h"
#import "EditViewController.h"
#import "EGODatabase.h"
#import "QueryModal.h"
#import "TableViewCell.h"
#import <CoreData/CoreData.h>
#import "User.h"
@interface ViewController ()
{
    NSMutableArray *dataArray;
    NSManagedObjectContext *context;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"用户列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUsers:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshUsers:)];
    
    [self _createTableView];
}

- (void)addUsers:(UIBarButtonItem *)btn {
    
    EditViewController *edvc = [[EditViewController alloc] init];
    [self.navigationController pushViewController:edvc animated:YES];
    
}

- (void)refreshUsers:(UIBarButtonItem *)btn {

    [self openDB];
    // 查询
    dataArray = [NSMutableArray array];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"[refreshUsers:]%@",error);
        return;
    }
    for (User *user in array) {
        QueryModal *modal = [[QueryModal alloc] init];
        modal.userName = user.userName;
        modal.age = user.age;
        [dataArray addObject:modal];
    }
    [_tableView reloadData];
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

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
     
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma - mark datasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.modal = dataArray[indexPath.row];
    return cell;
}

#pragma - mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
