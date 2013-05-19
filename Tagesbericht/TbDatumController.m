//
//  TbDatumViewController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 25.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbDatumController.h"

@implementation TbDatumController

#pragma mark - view controller methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveData];
    [super viewWillDisappear:animated];
}

#pragma mark - helper methods

- (void)loadData
{
    if (self.tagesbericht.datum) {
        self.datumDatePicker.date = self.tagesbericht.datum;
    }
}

- (void)saveData
{
    self.tagesbericht.datum = self.datumDatePicker.date;
}

@end
