//
//  TbLeistungenViewController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 25.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbLeistungListController.h"
#import "Tagesbericht.h"
#import "Leistung.h"
#import "TbLeistungController.h"
#import "TbLeistungBeschreibungController.h"
#import "TbAppDelegate.h"

@implementation TbLeistungListController

- (NSString*) segueIdForShowObject
{
    NSString *result;
    if (self.leistungsart == Lst_Material) {
        result = @"showBeschreibungDirectly";
    } else {
        result = [super segueIdForShowObject];
    }
    return result;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showBeschreibungDirectly"]) {
        TbLeistungBeschreibungController *controller =
            (TbLeistungBeschreibungController *)[segue destinationViewController];
        TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSArray *alleBeschreibungen = [appDelegate alleBeschreibungenForLeistungsart:Lst_Material];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Leistung *selectedLeistung = [self objectAtIndex:indexPath.row];
        [(TbLeistungBeschreibungController *)controller setLeistung:selectedLeistung];
        [(TbLeistungBeschreibungController *)controller setAutoSuggestions:alleBeschreibungen];
    } else {
        TbLeistungController *controller =
            (TbLeistungController *)[segue destinationViewController];
        [controller setLeistungsart:self.leistungsart];
        [super prepareForSegue:segue sender:sender];
    }
}

#pragma mark model adapter methods

- (id) createNewObject
{
    TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Leistung *leistung = [appDelegate createLeistung];
    leistung.minuten = @0;
    leistung.art = [NSNumber numberWithInt:self.leistungsart];
    
    return leistung;
}

- (void)addObject:(id)object atIndex:(NSUInteger)index
{
    if (self.leistungsart == Lst_Leistung) {
        //Leistung* l = (Leistung *)object;
        //[self.tagesbericht addLeistungen:[NSSet setWithObject:object]];
        [self.tagesbericht insertObject:(Leistung *)object inLeistungenAtIndex:index];
    } else if (self.leistungsart == Lst_Maschine) {
        [self.tagesbericht insertObject:(Leistung *)object inMaschinenAtIndex:index];
    } else {  // == Lst_Material
        [self.tagesbericht insertObject:(Leistung *)object inMaterialAtIndex:index];
    }
}

- (id)objectAtIndex:(NSUInteger)index
{
    id object;
    if (self.leistungsart == Lst_Leistung) {
        object = [self.tagesbericht.leistungen objectAtIndex:index];
    } else if (self.leistungsart == Lst_Maschine) {
        object = [self.tagesbericht.maschinen objectAtIndex:index];
    } else {  // == Lst_Material
        object = [self.tagesbericht.material objectAtIndex:index];
    }
    
    return object;
}

- (NSArray*)objects
{
    NSArray *leistungen;
    if (self.leistungsart == Lst_Leistung) {
        leistungen = [self.tagesbericht.leistungen array];
    } else if (self.leistungsart == Lst_Maschine) {
        leistungen = [self.tagesbericht.maschinen array];
    } else {  // == Lst_Material
        leistungen = [self.tagesbericht.material array];
    }
    
    return leistungen;
}

- (NSUInteger)objectCount
{
    NSUInteger result = 0;
    if (self.leistungsart == Lst_Leistung) {
        result = [self.tagesbericht.leistungen count];
    } else if (self.leistungsart == Lst_Maschine) {
        result = [self.tagesbericht.maschinen count];
    } else {  // == Lst_Material
        result = [self.tagesbericht.material count];
    }

    return result;
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    if (self.leistungsart == Lst_Leistung) {
        [self.tagesbericht removeObjectFromLeistungenAtIndex:index];
    } else if (self.leistungsart == Lst_Maschine) {
        [self.tagesbericht removeObjectFromMaschinenAtIndex:index];
    } else {  // == Lst_Material
        [self.tagesbericht removeObjectFromMaterialAtIndex:index];
    }
}

- (void)deleteObject:(id)object
{
    TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate deleteLeistung:(Leistung *)object];
}

- (NSString*)objectText:(id)object
{
    return [object description];
}

@end
