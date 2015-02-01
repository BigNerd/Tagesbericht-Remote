//
//  TbObjectController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 28.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbObjectController.h"

@implementation TbObjectController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.objectTitle) {
        self.navigationItem.title = self.objectTitle;
    }
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadData]; //repeat this call once more to really refresh uitableviewcell labels...
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveData];
    [super viewWillDisappear:animated];
}

/*
 * Override this method by loading models into views
 */
- (void)loadData
{
}

/*
 * Override this method by saving view into models
 */
- (void)saveData
{
}

@end
