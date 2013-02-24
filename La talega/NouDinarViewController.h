//
//  NouDinarViewController.h
//  La talega
//
//  Created by Macbomb on 19/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NouDinarDelegate <NSObject>

-(void)introNouDinar:(NSDictionary*)dinarNou;

@end

@interface NouDinarViewController : UIViewController <UITableViewDelegate>

@property (nonatomic, strong) id <NouDinarDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btFet;

@property (strong, nonatomic) IBOutlet UIImageView *viewFons;

- (IBAction)btCancel:(UIBarButtonItem *)sender;
- (IBAction)btFetPush:(id)sender;

@end
