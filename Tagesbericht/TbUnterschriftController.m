//
//  TbUnterschriftAuftraggeberViewController.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 28.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TbUnterschriftController.h"
#import "GRMustache.h"

@interface TbUnterschriftController ()

@property NSString *tagesberichtAsHTML;

@end

@implementation TbUnterschriftController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearImage:)];

    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendReport:)];
    
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:clearButton, nil];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:sendButton, nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveData];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearImage:(id) sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Unterschrift löschen?"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"Abbrechen"
                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Do it!
        [self doClearImage];
    } else {
        // Cancel
    }
}

- (void)doClearImage
{
    [self.unterschriftImageView clear];
}

- (void)sendReport:(id) sender
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Tagesbericht"];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *toRecipient = [userDefaults stringForKey:@"EmailRecipient"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:toRecipient, nil];
        [mailer setToRecipients:toRecipients];
        
        NSData *htmlData = [self.tagesberichtAsHTML dataUsingEncoding:NSUTF8StringEncoding];
        [mailer addAttachmentData:htmlData mimeType:@"text/html" fileName:@"Tagesbericht"];
        
        UIImage *myImage = self.unterschriftImageView.image;
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"Unterschrift"];
        
        NSString *emailBody = self.tagesberichtAsHTML;
        [mailer setMessageBody:emailBody isHTML:YES];
        [self presentViewController:mailer animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler"
                                                        message:@"Email-Versand ist nicht möglich."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            [[self navigationController] popToRootViewControllerAnimated:YES];
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }    
}

#pragma mark - helper methods

- (void)loadData
{
    static GRMustacheTemplate *template = nil;
    if (!template) {
        template = [GRMustacheTemplate
            templateFromResource:@"Tagesbericht-Html"
                          bundle:[NSBundle mainBundle]
                           error:NULL];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY"];
    id data = @{
        @"bericht": self.tagesbericht,
        @"dateFormatter": dateFormatter
    };
    
    self.tagesberichtAsHTML = [template renderObject:data error:NULL];
    [self.tagesberichtWebView loadHTMLString:self.tagesberichtAsHTML baseURL:nil];
    self.unterschriftImageView.image = [UIImage imageWithData:self.tagesbericht.unterschrift];
}

- (void)saveData
{
    NSData *imageData = UIImagePNGRepresentation(self.unterschriftImageView.image);
    self.tagesbericht.unterschrift = imageData;
}

@end
