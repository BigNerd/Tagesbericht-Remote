//
//  TbLeistungController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 29.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbLeistungController.h"
#import "TbLeistungNameController.h"
#import "TbLeistungStundenController.h"
#import "TbLeistungBeschreibungController.h"
#import "TbAppDelegate.h"

@implementation TbLeistungController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL hidden = [self.objectTitle isEqualToString:@"Material"];
    self.nameCell.hidden = hidden;
    self.stundenCell.hidden = hidden;        
}

- (Leistung*)leistung
{
    return (Leistung*)self.object;
}

- (NSArray*)alleLeistungen
{
    return self.objectList;
}

- (void)loadData
{
    if (self.leistung.name) {
        self.nameCell.detailTextLabel.text = self.leistung.name;
        [self.nameCell setNeedsLayout];
    }
    if (self.leistung.minuten) {
        NSString* stundenUndMinuten =
            [NSString stringWithFormat:@"%02d:%02d",
                self.leistung.stunden, self.leistung.minutenOhneVolleStunden];
        self.stundenCell.detailTextLabel.text = stundenUndMinuten;
        [self.stundenCell setNeedsLayout];
    }
    if (self.leistung.beschreibung) {
        self.beschreibungCell.detailTextLabel.text = self.leistung.beschreibung;
        [self.beschreibungCell setNeedsLayout];
    }
}

- (void)saveData
{

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *controller = [segue destinationViewController];
    TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([[segue identifier] isEqualToString:@"showName"]) {
        NSArray *alleNamen = [appDelegate alleNamen];
        [(TbLeistungNameController *)controller setLeistung:self.leistung];
        [(TbLeistungNameController *)controller setAutoSuggestions:alleNamen];
    } else if ([[segue identifier] isEqualToString:@"showStunden"]) {
        [(TbLeistungStundenController *)controller setLeistung:self.leistung];
    } else if ([[segue identifier] isEqualToString:@"showBeschreibung"]) {
        NSArray *alleBeschreibungen =
            [appDelegate alleBeschreibungenForLeistungsart:self.leistungsart];
        [(TbLeistungBeschreibungController *)controller setLeistung:self.leistung];
        [(TbLeistungBeschreibungController *)controller setAutoSuggestions:alleBeschreibungen];
    }
}

@end
