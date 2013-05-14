//
//  TbTagesbericht.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TbTagesbericht : NSObject

@property (strong, nonatomic) NSString *auftraggeber;
@property (strong, nonatomic) NSString *baustelle;
@property (strong, nonatomic) NSDate *datum;
@property (strong, nonatomic) NSMutableArray *leistungen;
@property (strong, nonatomic) NSMutableArray *maschinen;
@property (strong, nonatomic) NSMutableArray *material;
@property (strong, nonatomic) NSString *notizen;
@property (strong, nonatomic) UIImage *unterschrift;

- (int)leistungsstunden;
- (int)leistungsminuten;

- (int)maschinenstunden;
- (int)maschinenminuten;

@end
