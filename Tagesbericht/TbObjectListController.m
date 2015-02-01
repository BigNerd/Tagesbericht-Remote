//
//  TbObjectListController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbObjectListController.h"
#import "TbTagesberichtController.h"

@implementation TbObjectListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     * Edit Button
     */
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    //self.editButtonItem.
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, nil];
    
    /*
     * Add Button
     */
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.objectListTitle) {
        self.navigationItem.title = self.objectListTitle;
    }    
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender
{
    NSObject *object = [self createNewObject];
    [self addObject:object atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView
     insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self performSegueWithIdentifier:[self segueIdForShowObject] sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showObject"]) {
        TbObjectController *controller = (TbObjectController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSObject *object = [self objectAtIndex:indexPath.row];
        [controller setObject:object];
        [controller setObjectList:[self objects]];
        [controller setObjectTitle:self.objectTitle];
    }
}

- (NSString*) segueIdForShowObject
{
    return @"showObject";
}

#pragma mark model adapter methods
/*
 * always override this method and return a proper object for the list
 */
- (id)createNewObject
{
    return nil;
}

/*
 * override this method if self.objectList is not used as the model
 */
- (void)addObject:(id)object atIndex:(NSUInteger)index
{
    [self.objectList insertObject:object atIndex:index];
}

/*
 * override this method if self.objectList is not used as the model
 */
- (id)objectAtIndex:(NSUInteger)index
{
    return self.objectList[index];
}

- (NSArray *)objects
{
    return self.objectList;
}

/*
 * override this method if self.objectList is not used as the model
 */
- (NSUInteger)objectCount
{
    return self.objectList.count;
}

/*
 * override this method if self.objectList is not used as the model
 */
- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.objectList removeObjectAtIndex:index];
}

/*
 * override this method if object must be deleted on removal from the list
 */
- (void)deleteObject:(id)object
{
}

/*
 * override this method if [object description] is not used as display text
 */
- (NSString*)objectText:(id)object
{
    return [object description];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self objectCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    NSObject *object = [self objectAtIndex:indexPath.row];
    cell.textLabel.text = [self objectText:object];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSObject *object = [self objectAtIndex:indexPath.row];
        [self removeObjectAtIndex:indexPath.row];
        [self deleteObject:object];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:[self segueIdForShowObject] sender:self];
}

@end
