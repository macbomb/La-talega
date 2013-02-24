//
//  TaulaDinarsViewController.h
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NouDinarViewController.h"
#import "DetallDinarViewController.h"

@interface TaulaDinarsViewController : UITableViewController <NouDinarDelegate, DetallDinarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbViewDinars;

- (IBAction)tornaInici:(UIBarButtonItem *)sender;

@end
