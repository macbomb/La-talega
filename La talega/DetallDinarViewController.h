//
//  DetallDinarViewController.h
//  La talega
//
//  Created by Macbomb on 23/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "ViewController.h"
#import "NouUsuariViewController.h"
@protocol DetallDinarDelegate <NSObject>

-(void)recargaTaulaDinars;

@end


@interface DetallDinarViewController : ViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) id <DetallDinarDelegate> delegate;

@property (nonatomic) int index;


@end
