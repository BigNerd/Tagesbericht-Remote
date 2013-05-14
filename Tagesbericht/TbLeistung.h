//
//  TbLeistung.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 25.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbLeistung : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *minuten;
@property (strong, nonatomic) NSString *beschreibung;

enum Leistungsart {Leistung = 0, Maschine = 1, Material = 2};
@property enum Leistungsart art;

- (int) stunden;
- (int) minutenOhneVolleStunden;

@end
