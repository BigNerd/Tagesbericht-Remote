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

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * minuten;
@property (strong, nonatomic) NSString * beschreibung;
@property (strong, nonatomic) NSNumber * art;
@property (strong, nonatomic) Tagesbericht *leistungenTagesbericht;
@property (strong, nonatomic) Tagesbericht *maschinenTagesbericht;
@property (strong, nonatomic) Tagesbericht *materialTagesbericht;

enum Leistungsart {Lst_Leistung = 0, Lst_Maschine = 1, Lst_Material = 2};

- (int) stunden;
- (int) minutenOhneVolleStunden;

@end
