//
//  ToDoItem+CoreDataProperties.m
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItem+CoreDataProperties.h"

@implementation ToDoItem (CoreDataProperties)

@dynamic todoName;
@dynamic todoDescription;
@dynamic todoOptionalDueDate;
@dynamic todoCompletionDate;
@dynamic todoPriority;

@end
