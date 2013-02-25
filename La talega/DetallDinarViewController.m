//
//  DetallDinarViewController.m
//  La talega
//
//  Created by Macbomb on 23/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "DetallDinarViewController.h"

@interface DetallDinarViewController (){
    
    UIScrollView *scrollview;
    NSMutableArray *usuarisMutableArray;
    NSMutableDictionary *rootDictionary;
    UITableView *tbComensals;
}

@end

@implementation DetallDinarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen]bounds];
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, CGRectGetHeight(screen)-44)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
        
        rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[self plistPath]];
        
        usuarisMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"usuaris"]];
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        usuarisMutableArray = [[NSMutableArray alloc] init];
    }
    CGRect rectTbComensals;
    if ([usuarisMutableArray count]>8) {
        rectTbComensals = CGRectMake(0, 0, 320, [usuarisMutableArray count] * 50 +200);
    }else {
        rectTbComensals = CGRectMake(0, 0, 320, 568);
    }
    tbComensals = [[UITableView alloc] initWithFrame:rectTbComensals style:UITableViewStyleGrouped];
    scrollview.contentSize = CGSizeMake(320, tbComensals.frame.size.height - 80);
    [tbComensals setBackgroundColor:[UIColor clearColor]];
    tbComensals.opaque = NO;
    tbComensals.scrollEnabled = NO;
    tbComensals.sectionHeaderHeight = 150;
    tbComensals.sectionFooterHeight = 30;
    tbComensals.allowsMultipleSelection = YES;
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondoNull2.png"]];
    [tbComensals addSubview:imgFons];
    [tbComensals setBackgroundView:imgFons];
    
    tbComensals.delegate = self;
    tbComensals.dataSource = self;
    [scrollview addSubview:tbComensals];
    
    UILabel *lbData = [[UILabel alloc] initWithFrame:CGRectMake(111, 21, 118, 28)];
    lbData.textAlignment = NSTextAlignmentLeft;
    lbData.backgroundColor = [UIColor clearColor];
    lbData.textColor = [UIColor blackColor];
    [lbData setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20]];
    //lbData.text = ;
    [scrollview addSubview:lbData];
    
    
}

-(NSString *)plistPath{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [rootPath stringByAppendingPathComponent:@"latalegaBD.plist"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end






