//
//  TbTagesbericht.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbTagesbericht.h"
#import "TbLeistung.h"

@implementation TbTagesbericht

- (NSString *)description
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM"];
    NSString *datumString = [dateFormat stringFromDate:self.datum];
    if (!self.baustelle) {
        self.baustelle = @"";
    }
    if (!self.auftraggeber) {
        self.auftraggeber = @"";
    }
    
    return [NSString stringWithFormat:@"%@ %@ [%@]", datumString, self.baustelle, self.auftraggeber];
}

- (int)leistungsstunden
{
    return [self summeLeistungsMinuten:self.leistungen] / 60;
}

- (int)leistungsminuten
{
    return [self summeLeistungsMinuten:self.leistungen] - (self.leistungsstunden * 60);
}

- (int)maschinenstunden
{
    return [self summeLeistungsMinuten:self.maschinen] / 60;
}

- (int)maschinenminuten
{
    return [self summeLeistungsMinuten:self.maschinen] - (self.maschinenstunden * 60);
}

- (int)summeLeistungsMinuten:(NSArray *)leistungen
{
    int summeMinuten = 0;
    for(TbLeistung *leistung in leistungen) {
        summeMinuten = summeMinuten + [leistung.minuten intValue];
    }
    return summeMinuten;
}

- (NSDateComponents*) datumAsDateComponents
{
    NSDateComponents *components =
        [[NSCalendar currentCalendar]
            components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
              fromDate: self.datum];
    
    return components;
}

@end
