//
//  TbLeistungController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 29.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbObjectController.h"
#import "Leistung.h"

@interface TbLeistungController : TbObjectController

- (Leistung*)leistung;

- (NSArray*)alleLeistungen;

@property enum Leistungsart leistungsart;

@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *stundenCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *beschreibungCell;

@end
