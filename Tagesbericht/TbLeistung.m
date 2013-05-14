//
//  TbLeistung.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 25.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbLeistung.h"

@implementation TbLeistung

- (NSString *)description
{
    NSString *result;
    if (self.art == Material) {
        result = self.beschreibung;
        if (!result) {
            result = @"";
        }
    } else {
        NSString *name = self.name;
        if (!name) {
            name = @"";
        }
        NSString *beschreibung = self.beschreibung;
        if (!beschreibung) {
            beschreibung = @"";
        }
        result = [NSString stringWithFormat:@"[%d:%d] %@ [%@]",
                  self.stunden, self.minutenOhneVolleStunden,beschreibung, name];
    }
    return result;
}

- (int) stunden
{
    return (self.minuten.intValue / 60);
}

- (int) minutenOhneVolleStunden
{
    return (self.minuten.intValue - self.stunden * 60);
}

@end
