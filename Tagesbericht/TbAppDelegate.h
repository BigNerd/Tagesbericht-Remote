//
//  TbAppDelegate.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Tagesbericht.h"
#import "Leistung.h"

@interface TbAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *tagesberichte;

- (Tagesbericht *) createTagesbericht;
- (void) deleteTagesbericht:(Tagesbericht *)tagesbericht;

- (Leistung *) createLeistung;
- (void) deleteLeistung:(Leistung *)leistung;

- (NSArray *)alleNamen;
- (NSArray *)alleBeschreibungenForLeistungsart:(enum Leistungsart)leistungsart;

@end
