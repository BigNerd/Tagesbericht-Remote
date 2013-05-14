//
//  TbLeistungenViewController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 25.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TbObjectListController.h"
#import "Tagesbericht.h"

/*
 * Die Segues dieses Controllers sind im Storyboard nicht von der Table Cell aus,
 * sondern vom Controller aus zu den Ziel-Controllern gezogen.
 * Auf diese Weise ist es möglich, den Ziel-Controller dynamisch zu bestimmen.
 */
@interface TbLeistungListController : TbObjectListController

@property (strong, nonatomic) Tagesbericht *tagesbericht;
@property enum Leistungsart leistungsart;

@end
