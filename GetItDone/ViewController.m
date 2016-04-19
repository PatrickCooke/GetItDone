//
//  ViewController.m
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ToDoItem.h"
#import "DetailViewController.h"



@interface ViewController ()

@property (nonatomic, strong)           AppDelegate            *appDelegate;
@property (nonatomic, strong)           NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)           NSArray                *todoArray;
@property (nonatomic,weak)    IBOutlet  UITableView            *todoTableView;

@end

@implementation ViewController

#pragma mark - Core Data Method

- (void)tempAddRecords { //creates command to fill database with temp info
     ToDoItem *newToDo = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [newToDo setTodoName:@"Do all the things"];
    [newToDo setTodoPriority:@"1"];
    [newToDo setTodoDescription:@"Get thing 1, thing 2, thing 3, and thing 4 done."];
    [newToDo setTodoCompletionDate: [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60]];
    [newToDo setTodoOptionalDueDate: [NSDate date]];
    ToDoItem *newToDo2 = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [newToDo2 setTodoName:@"Watch Star Wars"];
    [newToDo2 setTodoPriority:@"2"];
    [newToDo2 setTodoDescription:@"Go home and watch the original Trilogy."];
    [newToDo2 setTodoCompletionDate: [NSDate dateWithTimeIntervalSinceNow:3 * 24 * 60 * 60]];
    [newToDo2 setTodoOptionalDueDate: [NSDate date]];
    ToDoItem *newToDo3 = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [newToDo3 setTodoName:@"Get Homework Done"];
    [newToDo3 setTodoPriority:@"3"];
    [newToDo3 setTodoDescription:@"Code what Tom assigned."];
    [newToDo3 setTodoCompletionDate: [NSDate dateWithTimeIntervalSinceNow:2 * 24 * 60 * 60]];
    [newToDo3 setTodoOptionalDueDate: [NSDate date]];
    [_appDelegate saveContext]; //saves into persistent memory
}


- (NSArray*)fetchToDo {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
            }

#pragma mark - ToDo Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _todoArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *iCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ToDoItem *currentToDo = _todoArray[indexPath.row];
    iCell.textLabel.text = [currentToDo todoName];
    iCell.detailTextLabel.text = [currentToDo todoPriority];
    return iCell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    NSIndexPath *indexPath = [_todoTableView indexPathForSelectedRow];
    ToDoItem *currentToDo = _todoArray[indexPath.row];
    destController.selectedToDo = currentToDo;
}




    
#pragma mark - Life Cycle Methods
    
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
//    [self tempAddRecords];
    _todoArray = [self fetchToDo];
    NSLog(@"Count %li", _todoArray.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
