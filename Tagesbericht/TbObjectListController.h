//
//  TbMasterViewController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbObjectListController : UITableViewController

@property (strong, nonatomic) NSMutableArray *objectList;

@property (strong, nonatomic) NSString *objectListTitle;

@property (strong, nonatomic) NSString *objectTitle;

- (NSString*) segueIdForShowObject;

#pragma mark model adapter methods

/*
 * always override this method and return a proper object for the list
 */
- (id)createNewObject;

/*
 * override this method if self.objectList is not used as the model
 */
- (void)addObject:(id)object atIndex:(NSUInteger)index;

/*
 * override this method if self.objectList is not used as the model
 */
- (id)objectAtIndex:(NSUInteger)index;

/*
 * override this method if self.objectList is not used as the model
 */
- (NSArray *)objects;

/*
 * override this method if self.objectList is not used as the model
 */
- (NSUInteger)objectCount;

/*
 * override this method if self.objectList is not used as the model
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/*
 * override this method if object must be deleted on removal from the list
 */
- (void)deleteObject:(id)object;

/*
 * override this method if [object description] is not used as display text
 */
- (NSString*)objectText:(id)object;

@end
