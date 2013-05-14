//
//  TbTagesberichtListController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 28.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "Tagesbericht.h"
#import "TbTagesberichtListController.h"
#import "TbTagesberichtController.h"
#import <CoreData/CoreData.h>
#import "TbAppDelegate.h"

@implementation TbTagesberichtListController

- (NSMutableArray *) objectList
{
    if (![super objectList]) {
        TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        self.objectList = [appDelegate tagesberichte];
    }
    return [super objectList];
}

- (id) createNewObject
{
    TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Tagesbericht* tagesbericht = [appDelegate createTagesbericht];
    tagesbericht.datum = [NSDate date];    
    return tagesbericht;
}

- (void)deleteObject:(id)object
{
    TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate deleteTagesbericht:(Tagesbericht *)object];
}

@end
