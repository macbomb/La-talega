//
//  NouUsuariViewController.h
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NouUsuariDelegate <NSObject>

-(void)introNousUsuaris:(NSArray*)usuarisNous;

@end

@interface NouUsuariViewController : UIViewController

@property (nonatomic, strong) id <NouUsuariDelegate> delegate;

- (IBAction)btOk:(id)sender;

- (IBAction)guardaUsuarisNous:(UIBarButtonItem *)sender;
- (IBAction)btTorna:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITextField *nomTexF;
@property (strong, nonatomic) IBOutlet UILabel *lbUltimNom;
@property (strong, nonatomic) IBOutlet UILabel *lbTotalNoms;

@end
