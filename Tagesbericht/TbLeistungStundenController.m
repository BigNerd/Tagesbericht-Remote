//
//  TbLeistungStundenController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbLeistungStundenController.h"

@implementation TbLeistungStundenController

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
    int minuten = [self.leistung.minuten intValue];
    self.stundenDatePicker.countDownDuration = minuten * 60.0;
}

- (void)saveData
{
    int minuten = self.stundenDatePicker.countDownDuration / 60;
    int minutenOhneStunden = minuten % 60;
    if (minutenOhneStunden == 1) {
        minuten = minuten - 1;
    }
    self.leistung.minuten = [NSNumber numberWithInt:minuten];
}

@end
