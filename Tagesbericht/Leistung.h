//
//  Leistung.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 10.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tagesbericht;

@interface Leistung : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * minuten;
@property (nonatomic, retain) NSString * beschreibung;
@property (nonatomic, retain) NSNumber * art;
@property (nonatomic, retain) Tagesbericht *leistungenTagesbericht;
@property (nonatomic, retain) Tagesbericht *maschinenTagesbericht;
@property (nonatomic, retain) Tagesbericht *materialTagesbericht;

enum Leistungsart {Lst_Leistung = 0, Lst_Maschine = 1, Lst_Material = 2};

- (int) stunden;
- (int) minutenOhneVolleStunden;

@end
