//
//  TbTextController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 29.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbTextController.h"

@interface TbTextController ()

//private
@property (strong, nonatomic) NSMutableArray *filteredAutoSuggestions;

//private
@property (strong, nonatomic) UITableView *autoSuggestTableView;

@end

@implementation TbTextController

#pragma mark pseudo abstract methods
//pseudo abstract
- (NSString *)text
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

//pseudo abstract
- (void)setText:(NSString *)text
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

//pseudo abstract

- (UITextField *)textTextField
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

#pragma mark - view controller methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.autoSuggestTableView = [[UITableView alloc]
                                 initWithFrame:CGRectMake(0, 50, 320, 120) style:UITableViewStylePlain];
    self.autoSuggestTableView.delegate = self;
    self.autoSuggestTableView.dataSource = self;
    self.autoSuggestTableView.scrollEnabled = YES;
    [self.view addSubview:self.autoSuggestTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    self.autoSuggestTableView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveData];
    [super viewWillDisappear:animated];
}

#pragma mark - the table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredAutoSuggestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = nil;
    UITableViewCell *cell = nil;
    if (cellIdentifier != nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    if (cell == nil) {
        cellIdentifier = @"CellIdentifier";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *filteredAutoSuggestion = [self.filteredAutoSuggestions objectAtIndex:indexPath.row];
    cell.textLabel.text = [filteredAutoSuggestion description];
    return cell;
}

#pragma mark - the table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.autoSuggestTableView cellForRowAtIndexPath:indexPath];
    self.textTextField.text = cell.textLabel.text;
    [self.textTextField resignFirstResponder];
}

#pragma mark - the text field delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.autoSuggestTableView.hidden = NO;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
    replacementString:(NSString *)string
{
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self filterAutoSuggestEntriesWithSubstring:substring];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self saveData];
    self.autoSuggestTableView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.textTextField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - helper methods

- (void)loadData
{
    self.textTextField.text = self.text;
}

- (void)saveData
{
    self.text = self.textTextField.text;
}

- (void)filterAutoSuggestEntriesWithSubstring:(NSString *)substring {
    // Put anything that starts with this substring into the filtered auto suggestions array
    // The items in this array is what will show up in the auto suggest table view
    self.filteredAutoSuggestions = [[NSMutableArray alloc] init];
    for(NSObject *autoSuggestion in self.autoSuggestions) {
        if ([[autoSuggestion description]
             rangeOfString:substring
             options:(NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch)].length > 0) {
            [self.filteredAutoSuggestions addObject:[autoSuggestion description]];
        }
    }
    /* Reduce autoSuggestion array to unique values */
    NSSet *set = [[NSSet alloc] initWithArray:self.filteredAutoSuggestions];
    [self.filteredAutoSuggestions removeAllObjects];
    [self.filteredAutoSuggestions addObjectsFromArray:[set allObjects]];
    
    [self.autoSuggestTableView reloadData];
}

@end
