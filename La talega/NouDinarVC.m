//
//  NouDinarVC.m
//  La talega
//
//  Created by Macbomb on 26/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "NouDinarVC.h"

@interface NouDinarVC (){
    
    NSMutableArray *usuarisMutableArray;
    NSMutableDictionary *rootDictionary;
    NSMutableArray *seleccioComensals;
    NSMutableDictionary *comensalMutDict;
    NSMutableArray *comensalsMutArr;
    NSDate *ara;
    NSString *stringAra;
    NSDateFormatter *formatData;
    UITextField *txfMenu;
    UITextField *txfNouUsuari;
    UIButton *btNouUsuari;
    UILabel *lbData;
}

@end

@implementation NouDinarVC

@synthesize tbNouDinar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    seleccioComensals = [[NSMutableArray alloc] init];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
        
        rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[self plistPath]];
        
        usuarisMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"usuaris"]];
        for (int i = 0; i < [usuarisMutableArray count]; i++) {
            [seleccioComensals addObject:[NSNumber numberWithBool:NO]];
        }
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        usuarisMutableArray = [[NSMutableArray alloc] init];
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(amagaTeclat)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    [tbNouDinar setBackgroundView:imgFons];
    [tbNouDinar setBackgroundColor:[UIColor clearColor]];
    tbNouDinar.opaque = NO;
}

-(void)amagaTeclat{
    
    [txfMenu resignFirstResponder];
    [txfNouUsuari resignFirstResponder];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int valor;
    switch (section) {
        case 0:
            valor = 2;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celaData = @"celaData";
    static NSString *celaMenu = @"celaMenu";
    static NSString *celaComensal = @"celaComensal";
    static NSString *celaNouComensal = @"celaNouComensal";
    
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:celaData];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celaData];
                    }
                    formatData = [[NSDateFormatter alloc] init];
                    [formatData setDateFormat:@"dd-MMM-YYYY"];
                    ara = [NSDate date];
                    stringAra = [formatData stringFromDate:ara];
                    lbData = (UILabel *)[cell viewWithTag:100];
                    [lbData setText:stringAra];
                    break;
                case 1:
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:celaMenu];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celaMenu];
                    }
                    txfMenu = (UITextField *)[cell viewWithTag:200];
                    txfMenu.placeholder = @"Menu";
                    
                    break;
            }
            cell.tag = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            break;
            
        case 1:
            
            cell = [tableView dequeueReusableCellWithIdentifier:celaComensal];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celaComensal];
            }
            cell.textLabel.text = [usuarisMutableArray objectAtIndex:indexPath.row];  [tableView cellForRowAtIndexPath:indexPath].selected = NO;
            cell.tag = indexPath.row;
            break;
            
        default:
            
            cell = [tableView dequeueReusableCellWithIdentifier:celaNouComensal];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celaNouComensal];
            }
            txfNouUsuari = (UITextField *)[cell viewWithTag:105];
            btNouUsuari = (UIButton *)[cell viewWithTag:106];
            [btNouUsuari addTarget:self action:@selector(introNouUsuari) forControlEvents:UIControlEventTouchUpInside];
            
            break;
    }
    
    return cell;
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //UIStoryboard *storyboard;
    switch (indexPath.section) {
        case 1:
            [seleccioComensals replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
            break;
            
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [seleccioComensals replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    }
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
	// create the parent view
	UIView * customSectionView = [[UIView alloc] initWithFrame:CGRectMake(0.0, -5, self.tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
	customSectionView.backgroundColor = [UIColor clearColor];
	
	// create the label
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, customSectionView.frame.size.height)];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    headerLabel.text = titolSeccio;
    // package and return
    [customSectionView addSubview:headerLabel];
    return customSectionView;
                        
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 0;
            break;
            
        default:
            return 30;
            break;
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
        
        [seleccioComensals removeAllObjects];
        for (int i = 0; i < [usuarisMutableArray count]; i++) {
            [seleccioComensals addObject:[NSNumber numberWithBool:NO]];
        }
        [tableView reloadData];
        
    }
    
}

#pragma mark - Metodo delegado

-(void)introNousUsuaris:(NSArray *)usuarisNous{
    
    for (int i = 0; i < usuarisNous.count; i++) {
        [usuarisMutableArray addObject:[usuarisNous objectAtIndex:i]];
    }
    [seleccioComensals removeAllObjects];
    for (int i = 0; i < [usuarisMutableArray count]; i++) {
        [seleccioComensals addObject:[NSNumber numberWithBool:NO]];
    }
    
    [tbNouDinar reloadData];
    [tbNouDinar reloadInputViews];
    
    [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    if (plistData) {
        [plistData writeToFile:[self plistPath] atomically:YES];
    }
}

#pragma mark - Accions botons

- (IBAction)introNouDinar:(UIBarButtonItem *)sender {
    NSString *menu = [txfMenu.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    bool seleccionat;
    int seleccionats = 0;
    comensalsMutArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [seleccioComensals count]; i++) {
        seleccionat = [[seleccioComensals objectAtIndex:i] boolValue];
        if (seleccionat) {
            comensalMutDict = [[NSMutableDictionary alloc] init];
            [comensalMutDict setObject:[usuarisMutableArray objectAtIndex:i] forKey:@"nomComensal"];
            [comensalMutDict setObject:[NSNumber numberWithInt:0] forKey:@"pagat"];
            [comensalsMutArr addObject:comensalMutDict];
            
            seleccionats ++;
        }
    }
    
    if (menu.length > 0 && seleccionats > 0) {
        
        NSMutableDictionary *nouDinarMutDict = [[NSMutableDictionary alloc] init];
        
        [nouDinarMutDict setObject:lbData.text forKey:@"data"];
        [nouDinarMutDict setObject:menu forKey:@"menu"];
        [nouDinarMutDict setObject:[NSNumber numberWithInt:0] forKey:@"preuTot"];
        [nouDinarMutDict setObject:[NSNumber numberWithInt:0] forKey:@"preuPerCap"];
        [nouDinarMutDict setObject:@"noImg.png" forKey:@"imatge"];
        [nouDinarMutDict setObject:comensalsMutArr forKey:@"comensals"];
        
        NSMutableArray *dinarsMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"dinars"]];
        [dinarsMutableArray addObject:nouDinarMutDict];
        [rootDictionary setObject:dinarsMutableArray forKey:@"dinars"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"actualitzaDades" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelaNouDinar:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)introNouUsuari{
    NSString *nomSenseEspais = [txfNouUsuari.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (nomSenseEspais.length  > 0) {
        txfNouUsuari.text = @"";
        [usuarisMutableArray addObject:nomSenseEspais];
        [tbNouDinar reloadData];
        [seleccioComensals removeAllObjects];
        for (int i = 0; i < [usuarisMutableArray count]; i++) {
            [seleccioComensals addObject:[NSNumber numberWithBool:NO]];
        }
        
        [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
    }
}
    





@end




