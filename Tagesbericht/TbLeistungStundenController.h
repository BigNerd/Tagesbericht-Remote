//
//  TbLeistungStundenController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Leistung.h"

@interface TbLeistungStundenController : UIViewController

@property (strong, nonatomic) Leistung *leistung;

@property (weak, nonatomic) IBOutlet UIDatePicker *stundenDatePicker;

@end
