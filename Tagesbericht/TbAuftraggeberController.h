//
//  TbAuftraggeberViewController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 24.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbTextController.h"
#import "Tagesbericht.h"

@interface TbAuftraggeberController : TbTextController

@property (strong, nonatomic) Tagesbericht *tagesbericht;

@property (weak, nonatomic) IBOutlet UITextField *auftraggeberTextField;

@end
