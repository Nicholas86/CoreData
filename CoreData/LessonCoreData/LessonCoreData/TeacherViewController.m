//
//  TeacherViewController.m
//  LessonCoreData
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import "TeacherViewController.h"
#import "StudentViewController.h"
#import "Student.h"
#import "Teacher.h"
#import "AppDelegate.h"
@interface TeacherViewController ()
//数据源
@property (nonatomic,strong) NSMutableArray *TeacherArray;
@property (nonatomic,strong) NSArray *studentArray;
@property (strong, nonatomic) NSIndexPath *indexPath;
///数据管理器
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContex;
@end

@implementation TeacherViewController

- (IBAction)addTeacher:(id)sender {
    //添加老师到数据源
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContex];
    teacher.name = [NSString stringWithFormat:@"虎哥%d号",arc4random() % 100];
    //给老师的集合赋值
    for (int i = 0; i < 3 ; i++) {
        Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContex];
        stu.name = [NSString stringWithFormat:@"小小%d",i];
        stu.teachership = teacher;
    }
    //将当前创造的老师添加到数据源中
    [self.TeacherArray addObject:teacher];
    //数据持久化
    [self.managedObjectContex save:nil];
    //添加cell
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"老师列表";
    //初始化数组
    self.TeacherArray = [NSMutableArray arrayWithCapacity:1];
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContex = appdelegate.managedObjectContext;
    //查询老师
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
    NSArray *temArray = [self.managedObjectContex executeFetchRequest:request error:nil];
    [self.TeacherArray addObjectsFromArray:temArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.TeacherArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Teacher *teacher = [self.TeacherArray objectAtIndex:indexPath.row];
    cell.textLabel.text = teacher.name;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据库中的数据
        Teacher *teacher = [self.TeacherArray objectAtIndex:indexPath.row];
        NSMutableSet *stter = [NSMutableSet setWithSet:teacher.studentship];
        for (Student *student in stter) {
            [self.managedObjectContex deleteObject:student];
            [self.managedObjectContex save:nil];
        }
        
        [self.managedObjectContex deleteObject:teacher];
        [self.managedObjectContex save:nil];
        //删除数据源
        [self.TeacherArray removeObjectAtIndex:indexPath.row];
        //删除cell单元格
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    
        
    }   
}
- (void)viewWillAppear:(BOOL)animated {
    /*
    if (!self.TeacherArray.count) {
        return;
    } else {
        
        NSArray *arr = [NSArray arrayWithArray:self.TeacherArray];
        for (Teacher *teacher in arr) {
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teachership == %@",teacher];
            request.predicate = predicate;
            self.studentArray = [self.managedObjectContex executeFetchRequest:request error:nil];
            if (!self.studentArray.count) {
                [self.managedObjectContex deleteObject:teacher];
                [self.managedObjectContex save:nil];
                [self.TeacherArray removeObject:teacher];
                [self.tableView reloadData];
            }
        }
    }
    */
    
    /*
    NSArray *arr = [NSArray arrayWithArray:self.TeacherArray];
    for (Teacher *teacher in arr) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teachership == %@",teacher];
        request.predicate = predicate;
        self.studentArray = [self.managedObjectContex executeFetchRequest:request error:nil];
        if (!teacher.studentship.count) {
            [self.managedObjectContex deleteObject:teacher];
            [self.managedObjectContex save:nil];
            [self.TeacherArray removeObject:teacher];
            [self.tableView reloadData];
        }
    }
    */

    Teacher *teacher = [self.TeacherArray objectAtIndex:self.indexPath.row];
    if (!teacher.studentship.count) {
        //删除数据库中的数据
        [self.managedObjectContex deleteObject:teacher];
        [self.managedObjectContex save:nil];
        //删除数据源
        [self.TeacherArray removeObjectAtIndex:self.indexPath.row];
        //删除cell单元格
        [self.tableView deleteRowsAtIndexPaths:@[_indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
    
    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StudentViewController *studentVC = segue.destinationViewController;
    studentVC.managedObjectContext = self.managedObjectContex;
    UITableViewCell *cell = sender;
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    self.indexPath = indexpath;
    Teacher *teacher = self.TeacherArray[indexpath.row];
    studentVC.teacher = teacher;
}


@end
