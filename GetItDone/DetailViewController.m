//
//  DetailViewController.m
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()


@property(nonatomic,weak) IBOutlet UITextField    *todoNametitle;
@property(nonatomic,weak) IBOutlet UILabel    *todoNameLabel;
@property(nonatomic,weak) IBOutlet UISegmentedControl    *todoprioritySegControl;
@property(nonatomic,weak) IBOutlet UIDatePicker         *todoOptionalDatePicker;
@property(nonatomic,weak) IBOutlet UIDatePicker         *todoFinalDatePicker;
@property(nonatomic,weak) IBOutlet UILabel    *todoOptionalDateLabel;
@property(nonatomic,weak) IBOutlet UILabel    *todoDeadlineDateLable;
@property(nonatomic,weak) IBOutlet UITextView *todoDescriptionTextView;



@end

@implementation DetailViewController

#pragma mark - Detail Change Method

-(IBAction)savebutton:(id)sender {
    NSString *priorityint = [NSString stringWithFormat:@"%ld",(long)_todoprioritySegControl.selectedSegmentIndex];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/dd/yy"];
    NSLog(@"Task Name: %@, Priority Level %@, Optional Date: %@, Final Due Date: %@, Description of the Task: %@",_todoNametitle.text, priorityint, [formatter stringFromDate:_todoOptionalDatePicker.date], [formatter stringFromDate:_todoFinalDatePicker.date], _todoDescriptionTextView.text);
}




#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M-dd-yyyy"];
    NSDate *optionalDueDate = _selectedToDo.todoOptionalDueDate;
    NSDate *finalDueDate = _selectedToDo.todoCompletionDate;
    _todoNametitle.text = _selectedToDo.todoName;
    NSInteger todoPriorityInt = _selectedToDo.todoPriority.integerValue;
    _todoprioritySegControl.selectedSegmentIndex = todoPriorityInt - 1;

    _todoOptionalDatePicker.date = optionalDueDate;
    _todoFinalDatePicker.date = finalDueDate;
    //_todoOptionalDateLabel.text = [NSString stringWithFormat:@"Optional Due Date %@", optionalDueDateString];
    //_todoDeadlineDateLable.text = [NSString stringWithFormat:@"Final Due Date %@", finalDueDateString];
    _todoDescriptionTextView.text = _selectedToDo.todoDescription;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
