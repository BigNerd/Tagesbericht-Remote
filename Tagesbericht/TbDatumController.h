//
//  TbDatumViewController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 25.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tagesbericht.h"

@interface TbDatumController : UIViewController

@property (strong, nonatomic) Tagesbericht *tagesbericht;

@property (weak, nonatomic) IBOutlet UIDatePicker *datumDatePicker;

@end
