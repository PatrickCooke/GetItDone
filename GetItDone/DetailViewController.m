//
//  DetailViewController.m
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()


@property (nonatomic,strong)        AppDelegate  *appDelegate;
@property (nonatomic,strong)    NSManagedObjectContext *managedObjectContext;
@property(nonatomic,weak) IBOutlet UITextField    *todoNametitle;
@property(nonatomic,weak) IBOutlet UILabel    *todoNameLabel;
@property(nonatomic,weak) IBOutlet UISegmentedControl    *todoprioritySegControl;
@property(nonatomic,weak) IBOutlet UIDatePicker         *todoOptionalDatePicker;
@property(nonatomic,weak) IBOutlet UIDatePicker         *todoFinalDatePicker;
@property(nonatomic,weak) IBOutlet UILabel    *todoOptionalDateLabel;
@property(nonatomic,weak) IBOutlet UISwitch     *completionDateSwitch;
@property(nonatomic,weak) IBOutlet UILabel      *completionLabel;
@property(nonatomic,weak) IBOutlet UILabel      *completionDateLabel;
@property(nonatomic,weak) IBOutlet UITextView *todoDescriptionTextView;




@end

@implementation DetailViewController


#pragma mark - Detail Change Method

-(void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}
-(IBAction)savebutton:(id)sender {
    NSString *priorityint = [NSString stringWithFormat:@"%ld",(long)_todoprioritySegControl.selectedSegmentIndex + 1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/dd/yy"];
    _selectedToDo.todoName = _todoNametitle.text;
    _selectedToDo.todoPriority = priorityint;
    _selectedToDo.todoOptionalDueDate = _todoOptionalDatePicker.date;
    _selectedToDo.todoDescription = _todoDescriptionTextView.text;
    [self saveAndPop];
}

-(IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Delete");
    [_managedObjectContext deleteObject:_selectedToDo];
    [self saveAndPop];
}

-(NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM d, yyyy";
    return [formatter stringFromDate:date];
}

-(IBAction)completionSwitchPressed:(id)sender {
    if (_completionDateSwitch.isOn) {
        NSDate *completedtoday = [NSDate date];
        _selectedToDo.todoCompletionDate = completedtoday;
        _todoprioritySegControl.selectedSegmentIndex = 4;
        _completionLabel.text = [NSString stringWithFormat:@"Completed on"];
        _completionDateLabel.text = [self formatDate: completedtoday];
    } else {
        _completionDateLabel.text = nil;
        _todoprioritySegControl.selectedSegmentIndex = 3;
        _selectedToDo.todoCompletionDate = nil;
        _completionLabel.text = [NSString stringWithFormat:@""];
        _completionDateLabel.text = [NSString stringWithFormat:@""];
    }
}





#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_selectedToDo == nil) {
        ToDoItem *newtodo = (ToDoItem *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:_managedObjectContext];
        _selectedToDo=newtodo;
        _todoNametitle.text = @"";
        _todoprioritySegControl.selectedSegmentIndex = 0;
        _todoOptionalDatePicker.date = [NSDate date];
        _todoFinalDatePicker = nil;
        _todoDescriptionTextView.text = @"";
    } else {
        NSDate *optionalDueDate = _selectedToDo.todoOptionalDueDate;
        _todoNametitle.text = _selectedToDo.todoName;
        NSInteger todoPriorityInt = _selectedToDo.todoPriority.integerValue;
        _todoprioritySegControl.selectedSegmentIndex = todoPriorityInt - 1;
        _todoOptionalDatePicker.date = optionalDueDate;
        if (_todoprioritySegControl.selectedSegmentIndex <4) {
            _todoFinalDatePicker = nil;
            [_completionDateSwitch setOn: false];
        }else if ((_todoprioritySegControl.selectedSegmentIndex = 4)){
            _completionLabel.text = [NSString stringWithFormat:@"Completed on"];
            _completionDateLabel.text = [self formatDate: _selectedToDo.todoCompletionDate];
            [_completionDateSwitch setOn: true];
        }
        _todoDescriptionTextView.text = _selectedToDo.todoDescription;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([_managedObjectContext hasChanges]) {
        [_managedObjectContext rollback];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
