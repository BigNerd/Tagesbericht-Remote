//
//  TbAuftraggeberViewController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 24.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbAuftraggeberController.h"

@implementation TbAuftraggeberController

#pragma mark pseudo abstract method implementations
- (NSString *)text
{
    return self.tagesbericht.auftraggeber;
}

- (void)setText:(NSString *)text
{
    self.tagesbericht.auftraggeber = text;
}

- (UITextField *)textTextField
{
    return self.auftraggeberTextField;
}

@end
