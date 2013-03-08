//
//  PagamentsVC.h
//  La talega
//
//  Created by Macbomb on 05/03/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagamentsVC : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableDictionary *comensalDict;

@property (strong, nonatomic) IBOutlet UILabel *lbData;
@property (strong, nonatomic) IBOutlet UILabel *lbNom;
@property (strong, nonatomic) IBOutlet UITextField *txfQuantitat;

@property (strong, nonatomic) IBOutlet UIButton *btPagat;
@property (strong, nonatomic) IBOutlet UIButton *btCancel;
@property (strong, nonatomic) IBOutlet UIButton *btNoHaPagat;


- (IBAction)paga:(id)sender;

- (IBAction)cancela:(id)sender;

- (IBAction)noPaga:(id)sender;


@end
