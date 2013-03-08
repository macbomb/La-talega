//
//  DetallDinarsTbViewControler.h
//  La talega
//
//  Created by Macbomb on 04/03/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetallDinarsTbViewControler : UITableViewController <UITextFieldDelegate>

- (IBAction)btCancelPush:(UIBarButtonItem *)sender;
-(void)setDinar:(NSDictionary *)dinar;

@property (strong, nonatomic) IBOutlet UITableView *tbDetallDinar;

@property (strong, nonatomic) NSDictionary *dinar;


@end
