//
//  TbDetailViewController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "Tagesbericht.h"
#import "Leistung.h"

#import "TbTagesberichtController.h"
#import "TbAuftraggeberController.h"
#import "TbDatumController.h"
#import "TbLeistungListController.h"
#import "TbUnterschriftController.h"
#import "TbBaustelleController.h"
#import "TbAppDelegate.h"

@interface TbTagesberichtController ()

@property (strong, nonatomic) UIBarButtonItem *duplicateButtonItem;
@property (strong, nonatomic) UIBarButtonItem *doneButtonItem;

@end

@implementation TbTagesberichtController

- (Tagesbericht*)tagesbericht
{
    return (Tagesbericht*)self.object;
}

- (NSMutableArray*)alleTagesberichte
{
    return (NSMutableArray*)self.objectList;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.duplicateButtonItem = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                      target:self action:@selector(copyTagesbericht:)];
    
    self.doneButtonItem = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
        target:self action:@selector(doneEditingUITextView:)];
    
    self.navigationItem.rightBarButtonItem = self.duplicateButtonItem;
    [self enableDisableDuplicateButton];
}

- (void)enableDisableDuplicateButton
{
    self.duplicateButtonItem.enabled = NO;
    if (self.tagesbericht.datum) {
        NSDate *nowDate = [[NSDate alloc] init];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd.MM.YYYY"];
        NSString *datumStringThen = [dateFormat stringFromDate:self.tagesbericht.datum];
        NSString *datumStringNow = [dateFormat stringFromDate:nowDate];
        
        if (![datumStringNow isEqualToString:datumStringThen]) {
            self.duplicateButtonItem.enabled = YES;
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem = self.doneButtonItem;
}

- (void)doneEditingUITextView:(id)sender
{
    self.navigationItem.rightBarButtonItem = self.duplicateButtonItem;
    [self.notizenTextView resignFirstResponder];
}

- (void)copyTagesbericht:(id)sender
{
    TbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Tagesbericht* tagesbericht = [appDelegate createTagesbericht];
    
    tagesbericht.auftraggeber = self.tagesbericht.auftraggeber;
    tagesbericht.baustelle = self.tagesbericht.baustelle;
    tagesbericht.datum = [NSDate date];
    
    [self.alleTagesberichte insertObject:tagesbericht atIndex:0];
    self.object = tagesbericht;
    [self viewWillAppear:YES];
}

- (void)loadData
{
    self.auftraggeberCell.detailTextLabel.text = self.tagesbericht.auftraggeber;
    self.baustelleCell.detailTextLabel.text = self.tagesbericht.baustelle;
    if (self.tagesbericht.datum) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd.MM.YYYY"];
        NSString *datumString = [dateFormat stringFromDate:self.tagesbericht.datum];
        self.datumCell.detailTextLabel.text = datumString;
    }
    self.leistungenCell.detailTextLabel.text =
        [NSString stringWithFormat:@"(%d)", self.tagesbericht.leistungen.count];
    self.maschinenCell.detailTextLabel.text =
        [NSString stringWithFormat:@"(%d)", self.tagesbericht.maschinen.count];
    self.materialCell.detailTextLabel.text =
        [NSString stringWithFormat:@"(%d)", self.tagesbericht.material.count];
    self.notizenTextView.text = self.tagesbericht.notizen;
}

- (void)saveData
{
    self.tagesbericht.notizen = self.notizenTextView.text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *controller = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"showAuftraggeber"]) {
        NSMutableArray *alleAuftraggeber = [[NSMutableArray alloc] init];
        for(Tagesbericht *tagesbericht in self.alleTagesberichte) {
            if (tagesbericht.auftraggeber) {
                [alleAuftraggeber addObject:tagesbericht.auftraggeber];
            }
        }
        [(TbAuftraggeberController *)controller setTagesbericht:self.tagesbericht];
        [(TbAuftraggeberController *)controller setAutoSuggestions:alleAuftraggeber];
    } else if ([[segue identifier] isEqualToString:@"showBaustelle"]) {
        NSMutableArray *alleBaustellen = [[NSMutableArray alloc] init];
        for(Tagesbericht *tagesbericht in self.alleTagesberichte) {
            if (tagesbericht.baustelle) {
                [alleBaustellen addObject:tagesbericht.baustelle];
            }
        }
        [(TbBaustelleController *)controller setTagesbericht:self.tagesbericht];
        [(TbBaustelleController *)controller setAutoSuggestions:alleBaustellen];
    } else if ([[segue identifier] isEqualToString:@"showDatum"]) {
        [(TbDatumController *)controller setTagesbericht:self.tagesbericht];
    } else if ([[segue identifier] isEqualToString:@"showLeistungen"]) {
        [(TbLeistungListController *)controller setTagesbericht:self.tagesbericht];
        [(TbLeistungListController *)controller setObjectListTitle:@"Leistungen"];
        [(TbLeistungListController *)controller setObjectTitle:@"Leistung"];
        [(TbLeistungListController *)controller setLeistungsart:Lst_Leistung];
    } else if ([[segue identifier] isEqualToString:@"showMaschinen"]) {
        [(TbLeistungListController *)controller setTagesbericht:self.tagesbericht];
        [(TbLeistungListController *)controller setObjectListTitle:@"Maschinen"];
        [(TbLeistungListController *)controller setObjectTitle:@"Maschinen"];
        [(TbLeistungListController *)controller setLeistungsart:Lst_Maschine];
    } else if ([[segue identifier] isEqualToString:@"showMaterial"]) {
        [(TbLeistungListController *)controller setTagesbericht:self.tagesbericht];
        [(TbLeistungListController *)controller setObjectListTitle:@"Material"];
        [(TbLeistungListController *)controller setObjectTitle:@"Material"];
        [(TbLeistungListController *)controller setLeistungsart:Lst_Material];
    } else if ([[segue identifier] isEqualToString:@"showUnterschrift"]) {
        [(TbUnterschriftController *)controller setTagesbericht:self.tagesbericht];
    }
}

@end
