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
    UILabel *lbData;
    UITextField *txfMenu;
    UITextField *txfPreutotal;
    UILabel *lbPreuPerCap;
    UIButton *btMesComensals;
    NSMutableArray *usuarisMutableArray;
    NSMutableDictionary *rootDictionary;
    NSMutableString *menuDinarNou;
    NSMutableString *preuPerCapNou;
    
    float preuPerCap;
    int comensalsTriats;
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
    
    preuPerCap = 0.0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
        
        rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[self plistPath]];
        
        usuarisMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"usuaris"]];
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        usuarisMutableArray = [[NSMutableArray alloc] init];
    }
    tbTriaComensals = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, CGRectGetHeight(screen)-50) style:UITableViewStyleGrouped];
    [tbTriaComensals setBackgroundColor:[UIColor clearColor]];
    tbTriaComensals.opaque = NO;
    tbTriaComensals.scrollEnabled = YES;
    tbTriaComensals.allowsMultipleSelection = YES;
    tbTriaComensals.delegate = self;
    tbTriaComensals.dataSource = self;
    [self.view addSubview:tbTriaComensals];
    
//    lbData = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 44)];
//    lbData.textAlignment = NSTextAlignmentCenter;
//    lbData.backgroundColor = [UIColor clearColor];
//    lbData.textColor = [UIColor whiteColor];
//    [lbData setFont:[UIFont fontWithName:@"Avenir-Black" size:24]];
//    

//    lbData.text = stringAra;
//    
//    txfMenu = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 260, 30)];
//    txfMenu.placeholder = @"Menú del dia";
//    txfMenu.borderStyle = UITextBorderStyleRoundedRect;
//    
//    txfPreuPerCap = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 100, 30)];
//    txfPreuPerCap.placeholder = @"Preu per cap";
//    txfPreuPerCap.borderStyle = UITextBorderStyleRoundedRect;
//    
//    UILabel *lbTitol = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 280, 21)];
//    lbTitol.textColor = [UIColor whiteColor];
//    lbTitol.backgroundColor = [UIColor clearColor];
//    lbTitol.textAlignment = NSTextAlignmentLeft;
//    [lbTitol setFont:[UIFont fontWithName:@"Avenir-Black" size:20]];
//    lbTitol.text = @"Tria els comensals:";
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(amagaTeclat)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;

}

-(void)amagaTeclat{
    
    [txfMenu resignFirstResponder];
    [txfPreutotal resignFirstResponder];
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
    int valor;
    switch (section) {
        case 0:
            valor = 4;
            break;
        case 1:
            valor = usuarisMutableArray.count;
            break;
        case 2:
            valor = 1;
            break;
    }
    return valor;
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
        case 2:
            titolSeccio = [NSString stringWithFormat:@""];
            break;
    }
    return titolSeccio;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdCelaCero = @"CellIdCelaCero";
    static NSString *CellIdCelaU = @"CellIdCelaU";
    static NSString *CellIdCelaDos = @"CellIdCelaDos";
    static NSString *CellIdCelaTres = @"CellIdCelaTres";
    static NSString *CellIdCelaQuatre = @"CellIdCelaQuatre";
    static NSString *CellIdCelaCinq = @"CellIdCelaCinq";
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdCelaCero];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdCelaCero];
                    }
                    formatData = [[NSDateFormatter alloc] init];
                    [formatData setDateFormat:@"dd-MMM-YYYY"];
                    ara = [NSDate date];
                    stringAra = [formatData stringFromDate:ara];
                    cell.textLabel.text = stringAra;
                    break;
                case 1:
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdCelaU];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdCelaU];
                    }
                    cell.textLabel.text = @"Menu";
                    txfMenu = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 220, 30)];
                    txfMenu.backgroundColor = [UIColor clearColor];
                    txfMenu.autocapitalizationType = UITextAutocapitalizationTypeSentences;
                    txfMenu.textAlignment = NSTextAlignmentLeft;
                    txfMenu.textColor = [UIColor blueColor];
                    txfMenu.placeholder = @"Menu del dia";
                    txfMenu.returnKeyType = UIReturnKeyDefault;
                    txfMenu.delegate = self;
                    [cell addSubview:txfMenu];
                    break;
                case 2:
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdCelaDos];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdCelaDos];
                    }
                    cell.textLabel.text = @"Preu total";
                    txfPreutotal = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 100, 30)];
                    txfPreutotal.backgroundColor = [UIColor clearColor];
                    txfPreutotal.autocapitalizationType = UITextAutocapitalizationTypeSentences;
                    txfPreutotal.textAlignment = NSTextAlignmentLeft;
                    txfPreutotal.textColor = [UIColor blueColor];
                    txfPreutotal.placeholder = @"Preu total";
                    txfPreutotal.keyboardType = UIKeyboardTypeDecimalPad;
                    txfPreutotal.delegate = self;
                    txfPreutotal.tag = 99;
                    [cell addSubview:txfPreutotal];
                    break;
                case 3:
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdCelaTres];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdCelaTres];
                    }
                    lbPreuPerCap = [[UILabel alloc] initWithFrame:CGRectMake(200, 2, 100, 40)];
                    [lbPreuPerCap setFont:[UIFont fontWithName:@"Avenir-Black" size:27]];
                    lbPreuPerCap.backgroundColor = [UIColor clearColor];
                    lbPreuPerCap.textColor = [UIColor colorWithRed:0.58984375 green:0.19921875 blue:0.19921875 alpha:1];
                    lbPreuPerCap.textAlignment = NSTextAlignmentRight;
                    lbPreuPerCap.text = [NSString stringWithFormat:@"%.02f €",preuPerCap];
                    [cell addSubview:lbPreuPerCap];
                    cell.textLabel.text = @"Preu per cap";
                    
                    break;
            }
            cell.tag = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            break;
            
        case 1:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdCelaQuatre];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdCelaQuatre];
            }
            cell.textLabel.text = [usuarisMutableArray objectAtIndex:indexPath.row];
            cell.tag = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
            
        default:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdCelaCinq];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdCelaCinq];
            }
            cell.textLabel.text = @"Nou comensal";
            cell.tag = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard;
    switch (indexPath.section) {
        case 1:
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            comensalsTriats ++ ;
            [self calculaPreuPerCap];
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
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        comensalsTriats -- ;
        [self calculaPreuPerCap];
    }
}

- (IBAction)btCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btFetPush:(id)sender {
    
    NSString *preuTotal = [txfPreutotal.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *menu = [txfMenu.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (preuTotal.length > 0 && menu.length > 0) {
        
        NSMutableDictionary *nouDinarMutDict = [[NSMutableDictionary alloc] init];
        
        [nouDinarMutDict setObject:lbData.text forKey:@"data"];
        [nouDinarMutDict setObject:preuTotal forKey:@"preuTotal"];
        [nouDinarMutDict setObject:menu forKey:@"menu"];
        
        [self.delegate introNouDinar:nouDinarMutDict];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark ) {
            comensalsTriats -- ;
        }
        [usuarisMutableArray removeObjectAtIndex:indexPath.row];
        [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
        [self calculaPreuPerCap];
        [tableView reloadData];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 99) {
        [self calculaPreuPerCap];
        
    }
}

-(void)calculaPreuPerCap{
    
    if (txfPreutotal.text.length >0 && comensalsTriats > 0) {
        float preuTotal = [txfPreutotal.text floatValue];
        
        preuPerCap = preuTotal / comensalsTriats;
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

#pragma mark - Gestion teclado

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
@end








