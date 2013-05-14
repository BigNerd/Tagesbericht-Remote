//
//  TbLeistungBeschreibungController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 01.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbLeistungBeschreibungController.h"

@implementation TbLeistungBeschreibungController

#pragma mark pseudo abstract method implementations
- (NSString *)text
{
    return self.leistung.beschreibung;
}

- (void)setText:(NSString *)text
{
    self.leistung.beschreibung = text;
}

- (UITextField *)textTextField
{
    return self.beschreibungTextField;
}

@end
