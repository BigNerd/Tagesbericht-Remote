//
//  TbTextController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 29.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbTextController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

//pseudo abstract
- (NSString *)text;

//pseudo abstract
- (void)setText:(NSString *)text;

//pseudo abstract
- (UITextField *)textTextField;

@property (strong, nonatomic) NSArray *autoSuggestions;

@end
