//
//  TbLeistungBeschreibungController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbTextController.h"
#import "Leistung.h"

@interface TbLeistungBeschreibungController : TbTextController

@property (strong, nonatomic) Leistung *leistung;

@property (weak, nonatomic) IBOutlet UITextField *beschreibungTextField;

@end
