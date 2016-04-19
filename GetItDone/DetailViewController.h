//
//  DetailViewController.h
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface DetailViewController : UIViewController

@property(nonatomic,strong) ToDoItem *selectedToDo;

@end
