//
//  StudentViewController.m
//  LessonCoreData
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import "StudentViewController.h"
#import "Student.h"
@interface StudentViewController ()
@property (nonatomic,strong) NSArray *studentArray;
@end

@implementation StudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学生列表";
 //根据teacher 获取到当前teacher管理下的所有的学生
    //学生的查询
    //指定查询那张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teachership == %@",self.teacher];
    request.predicate = predicate;
     self.studentArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.studentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bb" forIndexPath:indexPath];
    Student *student = self.studentArray[indexPath.row];
    cell.textLabel.text = student.name;
    return cell;
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Student *student = self.studentArray[indexPath.row];
        
        [self.managedObjectContext deleteObject:student];
        [self.managedObjectContext save:nil];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.studentArray];
        [arr removeObjectAtIndex:indexPath.row];
        self.studentArray = [NSArray arrayWithArray:arr];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
