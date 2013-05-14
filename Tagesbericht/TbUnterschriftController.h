//
//  TbUnterschriftAuftraggeberViewController.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 28.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TbCanvasImageView.h"
#import "Tagesbericht.h"
#import <MessageUI/MessageUI.h>

@interface TbUnterschriftController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) Tagesbericht *tagesbericht;

@property (weak, nonatomic) IBOutlet UIWebView *tagesberichtWebView;

@property (weak, nonatomic) IBOutlet TbCanvasImageView *unterschriftImageView;

@end
