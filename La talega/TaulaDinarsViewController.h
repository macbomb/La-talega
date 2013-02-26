//
//  TaulaDinarsViewController.h
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetallDinarViewController.h"
#import "NouDinarVC.h"

@interface TaulaDinarsViewController : UITableViewController <NouDinarVCDelegate, DetallDinarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbViewDinars;


@end
