//
//  NouDinarVC.h
//  La talega
//
//  Created by Macbomb on 26/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NouDinarVC : UITableViewController < UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tbNouDinar;

- (IBAction)introNouDinar:(UIBarButtonItem *)sender;
- (IBAction)cancelaNouDinar:(UIBarButtonItem *)sender;

@end
