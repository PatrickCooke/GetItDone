//
//  DetailViewController.m
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property(nonatomic,weak) IBOutlet UILabel    *todoNameLabel;
@property(nonatomic,weak) IBOutlet UILabel    *todopriorityLabel;
@property(nonatomic,weak) IBOutlet UILabel    *todoOptionalDateLabel;
@property(nonatomic,weak) IBOutlet UILabel    *todoDeadlineDateLable;
@property(nonatomic,weak) IBOutlet UITextView *todoDescriptionTextView;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _todoNameLabel.text = _selectedToDo.todoName;
    _todopriorityLabel.text = [NSString stringWithFormat:@"This is a %@ priority ToDo",_selectedToDo.todoPriority];
    _todoOptionalDateLabel.text = [NSString stringWithFormat:@"%@", _selectedToDo.todoOptionalDueDate];
    _todoDeadlineDateLable.text = [NSString stringWithFormat:@"%@", _selectedToDo.todoCompletionDate];
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
