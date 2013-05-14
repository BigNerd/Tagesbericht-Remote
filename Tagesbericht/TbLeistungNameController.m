//
//  LeistungNameController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbLeistungNameController.h"

@implementation TbLeistungNameController

#pragma mark pseudo abstract method implementations
- (NSString *)text
{
    return self.leistung.name;
}

- (void)setText:(NSString *)text
{
    self.leistung.name = text;
}

- (UITextField *)textTextField
{
    return self.nameTextField;
}

@end
