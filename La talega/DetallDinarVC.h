//
//  DetallDinarVC.h
//  La talega
//
//  Created by Macbomb on 05/03/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PagamentsVC.h"

@interface DetallDinarVC : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>

- (IBAction)tbTornar:(UIBarButtonItem *)sender;

- (IBAction)pujaVista:(id)sender;

- (IBAction)baixaVista:(id)sender;

@property (strong, nonatomic) NSMutableDictionary *dinar;
@property (nonatomic, assign) int idDinar;

@property (strong, nonatomic) IBOutlet UITableView *tbDetallDinar;

@end
