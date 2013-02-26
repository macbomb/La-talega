//
//  NouDinarVC.h
//  La talega
//
//  Created by Macbomb on 26/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NouUsuariViewController.h"

@protocol NouDinarVCDelegate <NSObject>

-(void)introNouDinar:(NSDictionary*)dinarNou;

@end

@interface NouDinarVC : UITableViewController <NouUsuariDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tbNouDinar;

@property (nonatomic, strong) id <NouDinarVCDelegate> delegate;

- (IBAction)introNouDinar:(UIBarButtonItem *)sender;
- (IBAction)cancelaNouDinar:(UIBarButtonItem *)sender;

@end
