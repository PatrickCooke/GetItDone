//
//  ToDoItem+CoreDataProperties.h
//  GetItDone
//
//  Created by Patrick Cooke on 4/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *todoName;
@property (nullable, nonatomic, retain) NSString *todoDescription;
@property (nullable, nonatomic, retain) NSDate *todoOptionalDueDate;
@property (nullable, nonatomic, retain) NSDate *todoCompletionDate;
@property (nullable, nonatomic, retain) NSString *todoPriority;

@end

NS_ASSUME_NONNULL_END
