//
//  TbBaustelleController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbTextController.h"
#import "Tagesbericht.h"

@interface TbBaustelleController : TbTextController

@property (strong, nonatomic) Tagesbericht *tagesbericht;

@property (weak, nonatomic) IBOutlet UITextField *baustelleTextField;

@end
