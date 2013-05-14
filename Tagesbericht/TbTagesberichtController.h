//
//  TbTagesberichtController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TbObjectController.h"
#import "Tagesbericht.h"

@interface TbTagesberichtController : TbObjectController <UITextViewDelegate>

- (Tagesbericht*)tagesbericht;

- (NSMutableArray*)alleTagesberichte;

@property (weak, nonatomic) IBOutlet UITableViewCell *auftraggeberCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *baustelleCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *datumCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *leistungenCell;

@property (weak, nonatomic) IBOutlet UITextView *notizenTextView;

@property (weak, nonatomic) IBOutlet UITableViewCell *maschinenCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *materialCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *unterschriftCell;

@end
