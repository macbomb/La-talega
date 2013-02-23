//
//  NouDinarViewController.m
//  La talega
//
//  Created by Macbomb on 19/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "NouDinarViewController.h"

@interface NouDinarViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSDate *ara;
    NSString *stringAra;
    NSDateFormatter *formatData;
    UITableView *tbTriaComensals;
    UIScrollView *scrollview;
    UILabel *lbData;
    UITextField *txfMenu;
    UITextField *txfPreuPerCap;
    NSMutableArray *usuarisMutableArray;
    NSMutableDictionary *rootDictionary;
    NSMutableArray *seleccionComensales;
}

@end

@implementation NouDinarViewController
@synthesize btFet;

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
	// Do any additional setup after loading the view.
    
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
    tbTriaComensals = [[UITableView alloc] initWithFrame:rectTbComensals style:UITableViewStyleGrouped];
    scrollview.contentSize = CGSizeMake(320, tbTriaComensals.frame.size.height - 80);
    [tbTriaComensals setBackgroundColor:[UIColor clearColor]];
    tbTriaComensals.scrollEnabled = NO;
    tbTriaComensals.sectionHeaderHeight = 150;
    tbTriaComensals.sectionFooterHeight = 30;
    tbTriaComensals.allowsMultipleSelection = YES;
    
    tbTriaComensals.delegate = self;
    tbTriaComensals.dataSource = self;
    [scrollview addSubview:tbTriaComensals];
    
    lbData = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 44)];
    lbData.textAlignment = NSTextAlignmentCenter;
    lbData.backgroundColor = [UIColor clearColor];
    lbData.textColor = [UIColor whiteColor];
    [lbData setFont:[UIFont fontWithName:@"Avenir-Black" size:24]];
    
    formatData = [[NSDateFormatter alloc] init];
    [formatData setDateFormat:@"dd-MMM-YYYY"];
    ara = [NSDate date];
    stringAra = [formatData stringFromDate:ara];
    lbData.text = stringAra;
    [scrollview addSubview:lbData];
    
    txfMenu = [[UITextField alloc] initWithFrame:CGRectMake(20, 72, 280, 30)];
    txfMenu.placeholder = @"Menú del dia";
    txfMenu.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:txfMenu];
    
    txfPreuPerCap = [[UITextField alloc] initWithFrame:CGRectMake(110, 110, 100, 30)];
    txfPreuPerCap.placeholder = @"Preu per cap";
    txfPreuPerCap.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:txfPreuPerCap];
    
    seleccionComensales = [[NSMutableArray alloc] init];
    

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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (usuarisMutableArray.count < 1) {
        return 1;
    }else{
        btFet.enabled = YES;
        return usuarisMutableArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellUser";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    if (usuarisMutableArray.count < 1) {
        
        cell.textLabel.text = @"No hi ha cap usuari.";
    }else{
        cell.textLabel.text = [usuarisMutableArray objectAtIndex:indexPath.row];
        cell.tag = indexPath.row;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([usuarisMutableArray count]>0) {
        
        NSString *nom = [usuarisMutableArray objectAtIndex:indexPath.row];
        NSMutableDictionary *nouComDict = [[NSMutableDictionary alloc]init];
        [nouComDict setObject:nom forKey:@"nom"];
        [nouComDict setObject:@"0" forKey:@"pagatParcial"];
        [nouComDict setObject:@"NO" forKey:@"pagat"];
        
        [seleccionComensales addObject:nouComDict];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([usuarisMutableArray count]>0) {
        [seleccionComensales removeObject:[usuarisMutableArray objectAtIndex:indexPath.row]];
    }
}

- (IBAction)btCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btFetPush:(id)sender {
    
    NSMutableDictionary *nouDinarMutDict = [[NSMutableDictionary alloc] init];
    
    [nouDinarMutDict setObject:lbData.text forKey:@"data"];
    [nouDinarMutDict setObject:txfPreuPerCap.text forKey:@"preuCap"];
    [nouDinarMutDict setObject:txfMenu.text forKey:@"menu"];
    [nouDinarMutDict setObject:seleccionComensales forKey:@"comensals"];
    
    [self.delegate introNouDinar:nouDinarMutDict];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end








