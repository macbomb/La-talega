//
//  TaulaUsuarisViewControler.h
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NouUsuariViewController.h"

@interface TaulaUsuarisViewControler : UITableViewController <NouUsuariDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbViewUsuaris;

- (IBAction)tornaInici:(UIBarButtonItem *)sender;


@end
