//
//  TbBaustelleController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbBaustelleController.h"

@implementation TbBaustelleController

#pragma mark pseudo abstract method implementations
- (NSString *)text
{
    return self.tagesbericht.baustelle;
}

- (void)setText:(NSString *)text
{
    self.tagesbericht.baustelle = text;
}

- (UITextField *)textTextField
{
    return self.baustelleTextField;
}

@end
