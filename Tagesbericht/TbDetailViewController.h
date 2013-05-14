//
//  TbDetailViewController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 14.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
