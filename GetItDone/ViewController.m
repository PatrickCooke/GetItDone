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
@property (nonatomic,weak)    IBOutlet  UIBarButtonItem        *sortbutton;

@end

@implementation ViewController

#pragma mark - Global Variables

BOOL sortBool = true;

#pragma mark - Save/Recall Method

-(void) refreshDataAndTable {
    _todoArray=[self fetchToDo];
    [_todoTableView reloadData];
}

#pragma mark - Core Data Method

- (void)tempAddRecords { //creates command to fill database with temp info
     ToDoItem *newToDo = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [newToDo setTodoName:@"Do all the things"];
    [newToDo setTodoPriority:@"1"];
    [newToDo setTodoDescription:@"Get thing 1, thing 2, thing 3, and thing 4 done."];
    [newToDo setTodoCompletionDate: [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60]];
    [newToDo setTodoOptionalDueDate: [NSDate date]];
    [newToDo setTodoCategory:@"D"];
    ToDoItem *newToDo2 = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [newToDo2 setTodoName:@"Watch Star Wars"];
    [newToDo2 setTodoPriority:@"2"];
    [newToDo2 setTodoDescription:@"Go home and watch the original Trilogy."];
    [newToDo2 setTodoCompletionDate: [NSDate dateWithTimeIntervalSinceNow:3 * 24 * 60 * 60]];
    [newToDo2 setTodoOptionalDueDate: [NSDate date]];
    [newToDo2 setTodoCategory:@"D"];
    ToDoItem *newToDo3 = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [newToDo3 setTodoName:@"Get Homework Done"];
    [newToDo3 setTodoPriority:@"3"];
    [newToDo3 setTodoDescription:@"Code what Tom assigned."];
    [newToDo3 setTodoCompletionDate: [NSDate dateWithTimeIntervalSinceNow:2 * 24 * 60 * 60]];
    [newToDo3 setTodoOptionalDueDate: [NSDate date]];
    [newToDo3 setTodoCategory:@"A"];
    [_appDelegate saveContext];
}


- (NSArray*)fetchToDo {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    //sort by priority level code
    if (sortBool) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"todoPriority" ascending:true];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"todoOptionalDueDate" ascending:true];
        [fetchRequest setSortDescriptors:@[sortDescriptor,sortDescriptor2]];
    } else if (!sortBool){
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"todoCategory" ascending:true];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"todoPriority" ascending:true];
        [fetchRequest setSortDescriptors:@[sortDescriptor,sortDescriptor2]];
    }
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"todoPriority" ascending:true];
//    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"todoOptionalDueDate" ascending:true];
//    [fetchRequest setSortDescriptors:@[sortDescriptor,sortDescriptor2]];
    //end of sort code
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
            }

#pragma mark - ToDo Table View Methods

-(IBAction)sortButtonPressed:(id)sender {
    sortBool = !sortBool;
    [self refreshDataAndTable];
    if (sortBool) {
        _sortbutton.title = @"Priority Sort";
    } else {
        _sortbutton.title = @"Category Sort";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _todoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *iCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ToDoItem *currentToDo = _todoArray[indexPath.row];
    iCell.textLabel.text = [currentToDo todoName];
    if (sortBool) {
        iCell.detailTextLabel.text = [currentToDo todoPriority];
    }else{
        iCell.detailTextLabel.text = [currentToDo todoCategory];
    }
    //coloring details
    if ([currentToDo.todoPriority isEqualToString:@"1"]) {
        iCell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(60/255.0) blue:(64/255.0) alpha:1];
        iCell.textLabel.textColor = [UIColor whiteColor];
        iCell.detailTextLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(121/255.0) blue:(127/255.0) alpha:1];
    } else if ([currentToDo.todoPriority isEqualToString:@"2"]){
        iCell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(181/255.0) blue:(191/255.0) alpha:1];
        iCell.textLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(60/255.0) blue:(64/255.0) alpha:1];
        iCell.detailTextLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(121/255.0) blue:(127/255.0) alpha:1];
    } else if ([currentToDo.todoPriority isEqualToString:@"3"]) {
        iCell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(242/255.0) blue:(255/255.0) alpha:1];
        iCell.textLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(60/255.0) blue:(64/255.0) alpha:1];;
        iCell.detailTextLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(121/255.0) blue:(127/255.0) alpha:1];
    }else if ([currentToDo.todoPriority isEqualToString:@"4"]) {
        iCell.backgroundColor = [UIColor whiteColor];
        iCell.textLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(60/255.0) blue:(64/255.0) alpha:1];
        iCell.detailTextLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(60/255.0) blue:(64/255.0) alpha:1];
    }else if ([currentToDo.todoPriority isEqualToString:@"5"]) {
        iCell.backgroundColor = [UIColor whiteColor];
        iCell.textLabel.textColor = [UIColor lightGrayColor];
        iCell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }else{
        iCell.backgroundColor = [UIColor whiteColor];
        iCell.textLabel.textColor = [UIColor blackColor];
        iCell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }

    iCell.textLabel.font = [UIFont fontWithName:@"Verdana" size:18.0 ];
    if (sortBool){
        iCell.detailTextLabel.font = [UIFont fontWithName:@"Courier" size:12.0];
    }else if (!sortBool){
        iCell.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:18.0];
    }
    iCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    tableView.separatorColor=[UIColor darkGrayColor];
    return iCell;
}
-(double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"delete");
        ToDoItem *toDoDelete = _todoArray[indexPath.row];
        [_managedObjectContext deleteObject:toDoDelete];
        [_appDelegate saveContext];
        [self refreshDataAndTable];
    }];
    return @[deleteAction];
}

#pragma mark - Segue info

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"editToDoSegue"]) {
        NSIndexPath *indexPath = [_todoTableView indexPathForSelectedRow];
        ToDoItem *currentToDo = _todoArray[indexPath.row];
        destController.selectedToDo = currentToDo;
    }else if ([[segue identifier] isEqualToString:@"addToDoSegue"]){
        destController.selectedToDo=nil;
    }
}


    
#pragma mark - Life Cycle Methods
    
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
   //[self tempAddRecords];
    _todoArray = [self fetchToDo];
    NSLog(@"Count %li", _todoArray.count);
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshDataAndTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
