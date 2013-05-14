//
//  TbObjectController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 28.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbObjectController : UITableViewController

@property (strong, nonatomic) NSObject *object;

@property (strong, nonatomic) NSArray *objectList;

@property (strong, nonatomic) NSString *objectTitle;

@end
