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
    NSDate *ara;
    NSString *stringAra;
    NSDateFormatter *formatData;
    UITextField *txfMenu;
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
    [tbNouDinar addSubview:imgFons];
    [tbNouDinar setBackgroundView:imgFons];
    [tbNouDinar setBackgroundColor:[UIColor clearColor]];
    tbNouDinar.opaque = NO;
}

-(void)amagaTeclat{
    
    [txfMenu resignFirstResponder];
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
                    txfMenu.placeholder = @"preu";
                    
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
            
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard;
    switch (indexPath.section) {
        case 1:
            [seleccioComensals replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
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
    NSMutableDictionary *comensalMutDict = [[NSMutableDictionary alloc] init];
    NSMutableArray *comensalsMutArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [seleccioComensals count]; i++) {
        seleccionat = [[seleccioComensals objectAtIndex:i] boolValue];
        if (seleccionat) {
            [comensalMutDict setObject:[usuarisMutableArray objectAtIndex:i] forKey:@"nomComensal"];
            [comensalMutDict setObject:[NSNumber numberWithBool:NO] forKey:@"pagat"];
            [comensalMutDict setObject:[NSNumber numberWithInt:0] forKey:@"pagatParcial"];
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
        
        
        [self.delegate introNouDinar:nouDinarMutDict];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelaNouDinar:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end




