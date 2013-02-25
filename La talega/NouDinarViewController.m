//
//  NouDinarViewController.m
//  La talega
//
//  Created by Macbomb on 19/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "NouDinarViewController.h"

@interface NouDinarViewController ()
{
    NSDate *ara;
    NSString *stringAra;
    NSDateFormatter *formatData;
    UITableView *tbTriaComensals;
    UIScrollView *scrollview;
    UILabel *lbData;
    UITextField *txfMenu;
    UITextField *txfPreuPerCap;
    UIButton *btMesComensals;
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
//    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, CGRectGetHeight(screen)-44)];
//    scrollview.backgroundColor = [UIColor clearColor];
//    scrollview.delegate = self;
//    [self.view addSubview:scrollview];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
        
        rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[self plistPath]];
        
        usuarisMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"usuaris"]];
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        usuarisMutableArray = [[NSMutableArray alloc] init];
    }
//    CGRect rectTbComensals;
//    if ([usuarisMutableArray count]>8) {
//        rectTbComensals = CGRectMake(0, 0, 320, [usuarisMutableArray count] * 50 +200);
//    }else {
//        rectTbComensals = CGRectMake(0, 0, 320, 568);
//    }
    tbTriaComensals = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, CGRectGetHeight(screen)-50) style:UITableViewStyleGrouped];
    [tbTriaComensals setBackgroundColor:[UIColor clearColor]];
    tbTriaComensals.opaque = NO;
    tbTriaComensals.scrollEnabled = YES;
//    tbTriaComensals.sectionHeaderHeight = 10;
//    tbTriaComensals.sectionFooterHeight = 40;
//    scrollview.contentSize = CGSizeMake(320, tbTriaComensals.frame.size.height);
    tbTriaComensals.allowsMultipleSelection = YES;
    
//    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondoNull2.png"]];
//    [tbTriaComensals addSubview:imgFons];
//    [tbTriaComensals setBackgroundView:imgFons];
    
    tbTriaComensals.delegate = self;
    tbTriaComensals.dataSource = self;
    [self.view addSubview:tbTriaComensals];
    
//    lbData = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 44)];
//    lbData.textAlignment = NSTextAlignmentCenter;
//    lbData.backgroundColor = [UIColor clearColor];
//    lbData.textColor = [UIColor whiteColor];
//    [lbData setFont:[UIFont fontWithName:@"Avenir-Black" size:24]];
//    
//    formatData = [[NSDateFormatter alloc] init];
//    [formatData setDateFormat:@"dd-MMM-YYYY"];
//    ara = [NSDate date];
//    stringAra = [formatData stringFromDate:ara];
//    lbData.text = stringAra;
//    [scrollview addSubview:lbData];
//    
//    txfMenu = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 280, 30)];
//    txfMenu.placeholder = @"Menú del dia";
//    txfMenu.borderStyle = UITextBorderStyleRoundedRect;
//    [scrollview addSubview:txfMenu];
//    
//    txfPreuPerCap = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 100, 30)];
//    txfPreuPerCap.placeholder = @"Preu per cap";
//    txfPreuPerCap.borderStyle = UITextBorderStyleRoundedRect;
//    [scrollview addSubview:txfPreuPerCap];
//    
//    UILabel *lbTitol = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 280, 21)];
//    lbTitol.textColor = [UIColor whiteColor];
//    lbTitol.backgroundColor = [UIColor clearColor];
//    lbTitol.textAlignment = NSTextAlignmentLeft;
//    [lbTitol setFont:[UIFont fontWithName:@"Avenir-Black" size:20]];
//    lbTitol.text = @"Tria els comensals:";
//    [scrollview addSubview:lbTitol];
    
    seleccionComensales = [[NSMutableArray alloc] init];
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(amagaTeclat)];
//    [scrollview addGestureRecognizer:gesture];
//    gesture.cancelsTouchesInView = NO;

}

-(void)amagaTeclat{
    
    [txfMenu resignFirstResponder];
    [txfPreuPerCap resignFirstResponder];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return usuarisMutableArray.count;
            break;
        default:
            return 1;
            break;
    }

}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titol = [NSString stringWithFormat:@"Esborra"];
    return titol;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titolSeccio;
    switch (section) {
        case 0:
            titolSeccio = [NSString stringWithFormat:@"Dades nou dinar"];
            break;
        case 1:
            titolSeccio = [NSString stringWithFormat:@"Tria els comensals"];
            break;
            
        default:
            titolSeccio = [NSString stringWithFormat:@""];
            break;
    }
    return titolSeccio;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellUser";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"text";
            cell.tag = indexPath.row;
            break;
            
        case 1:
            cell.textLabel.text = [usuarisMutableArray objectAtIndex:indexPath.row];
            cell.tag = indexPath.row;
            break;
            
        default:
            cell.textLabel.text = @"Nou comensal";
            cell.tag = indexPath.row;
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *nouComDict;
    NSString *nom;
    UIStoryboard *storyboard;
    switch (indexPath.section) {
        case 1:
            
            nom = [usuarisMutableArray objectAtIndex:indexPath.row];
            nouComDict = [[NSMutableDictionary alloc]init];
            [nouComDict setObject:nom forKey:@"nom"];
            [nouComDict setObject:@"0" forKey:@"pagatParcial"];
            [nouComDict setObject:@"NO" forKey:@"pagat"];
            break;
            
        case 2:
            
            storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"bundle:nil];
            NouUsuariViewController *nouComensalViewC = [storyboard instantiateViewControllerWithIdentifier:@"nouComensalViewC"];
            nouComensalViewC.delegate = self;
            [self presentViewController:nouComensalViewC animated:YES completion:NULL];
            
            break;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [seleccionComensales removeObject:[usuarisMutableArray objectAtIndex:indexPath.row]];
    }
}

- (IBAction)btCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btFetPush:(id)sender {
    
    NSString *preuPerCap = [txfPreuPerCap.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *menu = [txfMenu.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (preuPerCap.length > 0 && menu.length > 0) {
        
        NSMutableDictionary *nouDinarMutDict = [[NSMutableDictionary alloc] init];
        
        [nouDinarMutDict setObject:lbData.text forKey:@"data"];
        [nouDinarMutDict setObject:preuPerCap forKey:@"preuCap"];
        [nouDinarMutDict setObject:menu forKey:@"menu"];
        [nouDinarMutDict setObject:seleccionComensales forKey:@"comensals"];
        
        [self.delegate introNouDinar:nouDinarMutDict];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        [usuarisMutableArray removeObjectAtIndex:indexPath.row];
        [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
        [tableView reloadData];
        
    }
}

#pragma mark - Metodo delegado

-(void)introNousUsuaris:(NSArray *)usuarisNous{
    
    for (int i = 0; i < usuarisNous.count; i++) {
        [usuarisMutableArray addObject:[usuarisNous objectAtIndex:i]];
    }
    
    [tbTriaComensals reloadData];
    [tbTriaComensals reloadInputViews];
    
    [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    if (plistData) {
        [plistData writeToFile:[self plistPath] atomically:YES];
    }
}


@end








