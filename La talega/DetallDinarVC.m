//
//  DetallDinarVC.m
//  La talega
//
//  Created by Macbomb on 05/03/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "DetallDinarVC.h"

@interface DetallDinarVC (){
    
    UITextField *txfPreuTotal;
    NSMutableArray *comensalsMutArray;
    UILabel *lbPreu;
    UIFont *fontEtiqueta;
}

@end

@implementation DetallDinarVC

@synthesize tbDetallDinar;
@synthesize dinar;
@synthesize idDinar;

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
    
    tbDetallDinar.dataSource = self;
    tbDetallDinar.delegate = self;
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    [tbDetallDinar addSubview:imgFons];
    [tbDetallDinar setBackgroundView:imgFons];
    [tbDetallDinar setBackgroundColor:[UIColor clearColor]];
    tbDetallDinar.opaque = NO;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(amagaTeclat)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actualitzaPagaments:) name:@"actualitzaPagaments" object:nil ];
    
    comensalsMutArray = [[NSMutableArray alloc] initWithArray:[dinar objectForKey:@"comensals"]];
    
    fontEtiqueta = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:18];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        default:
            return [comensalsMutArray count];
            break;
            
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 340;
            break;
            
        case 1:
            return 50;
            break;
            
        default:
            return 50;
            break;
            
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellDinar = @"CellDinar";
    static NSString *CellPreu = @"CellPreu";
    static NSString *CellComensal = @"CellComensal";
    
    UILabel *lbdata;
    UILabel *lbMenu;
    UIImageView *imgDimar;
    NSString *preuPerCap;
    UILabel *lbComensal;
    UILabel *lbEstat;
    NSString *textLbEstat;
    NSDictionary *comensal;
    
    UITableViewCell *cell = nil;
    
    
    float preuCapInt = [[dinar objectForKey:@"preuPerCap"] floatValue];
    switch (indexPath.section) {
        case 0:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellDinar];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellDinar];
            }
            
            lbdata = (UILabel *)[cell viewWithTag:120];
            lbdata.text = [dinar objectForKey:@"data"];
            
            lbMenu = (UILabel *)[cell viewWithTag:121];
            [lbMenu setText:[dinar objectForKey:@"menu"]];
            
            imgDimar = (UIImageView *)[cell viewWithTag:122];
            imgDimar.image = [UIImage imageNamed:[dinar objectForKey:@"imatge"]];
            
            lbPreu = (UILabel *)[cell viewWithTag:123];
            preuPerCap = [NSString stringWithFormat:@"%.02f €",preuCapInt];
            lbPreu.text = preuPerCap;
            
            break;
        case 1:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellPreu];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellPreu];
            }
            
            txfPreuTotal = (UITextField *)[cell viewWithTag:124];
            float preuTotal = [[dinar objectForKey:@"preuTot"] floatValue];
            txfPreuTotal.placeholder = [NSString stringWithFormat:@"%.02f €",preuTotal];
            txfPreuTotal.delegate = self;
            break;
        default:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellComensal];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellComensal];
            }
            
            comensal = [[NSDictionary alloc] initWithDictionary:[comensalsMutArray objectAtIndex:indexPath.row]];
            
            lbComensal = (UILabel *)[cell viewWithTag:126];
            lbComensal.text = [comensal objectForKey:@"nomComensal"];
            
            lbEstat = (UILabel *)[cell viewWithTag:127];
            float pagat = [[comensal objectForKey:@"pagat"] floatValue];
            float faltaPagar = preuCapInt - pagat;
            
            if (preuCapInt > 0) {
                
                if ( faltaPagar == 0) {
                    lbEstat.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.2 alpha:1.0];
                    textLbEstat = @"Pagat";
                }else{
                    lbEstat.backgroundColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
                    if (faltaPagar > 1) {
                        textLbEstat = [NSString stringWithFormat:@"Falten %.02f €",faltaPagar];
                    }else{
                        textLbEstat = [NSString stringWithFormat:@"Falta %.02f €",faltaPagar];
                    }
                    
                }
                
                CGSize mida = [self midaLabel:textLbEstat];
                lbEstat.frame = CGRectMake(220 - mida.width, 10, mida.width + 20, mida.height + 5);
                lbEstat.text = textLbEstat;
                lbEstat.layer.cornerRadius = 4.0f;
                
            }
            
            cell.tag = indexPath.row;
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titol = [NSString stringWithFormat:@""];
    if (indexPath.section == 2) {
        titol = @"pagat";
    }
    return titol;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UITableViewCell *cell = (UITableViewCell *)sender;
    if ([segue.identifier isEqualToString:@"GoToPagaments"]) {
        PagamentsVC *pagamentsVC = (PagamentsVC*)segue.destinationViewController;
        
        NSMutableDictionary *comensalMutDict = [[NSMutableDictionary alloc] initWithDictionary:[comensalsMutArray objectAtIndex:cell.tag]];
        [comensalMutDict setObject:[dinar objectForKey:@"preuPerCap"] forKey:@"preuPerCap"];
        [comensalMutDict setObject:[dinar objectForKey:@"data"] forKey:@"data"];
        [comensalMutDict setObject:[NSNumber numberWithInt:cell.tag] forKey:@"idComensal"];
        pagamentsVC.comensalDict = comensalMutDict;
    }
}


- (IBAction)tbTornar:(UIBarButtonItem *)sender {
    NSMutableDictionary *rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[self plistPath]];
    NSMutableArray *dinarsMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"dinars"]];
    [dinarsMutableArray removeObjectAtIndex:idDinar];
    [dinarsMutableArray insertObject:dinar  atIndex:idDinar];
    [rootDictionary setValue:dinarsMutableArray forKey:@"dinars"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    
    if (plistData) {
        [plistData writeToFile:[self plistPath] atomically:YES];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"actualitzaDades" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)plistPath{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [rootPath stringByAppendingPathComponent:@"latalegaBD.plist"];
}

#pragma mark - actualitzaPagaments

-(void)actualitzaPagaments:(NSDictionary *)pagament{
    
    NSMutableDictionary *pagamentComensal = [pagament valueForKey:@"userInfo"];
    int idComensal = [[pagamentComensal objectForKey:@"idComensal"] integerValue];
    [pagamentComensal removeObjectForKey:@"idComensal"];
    [comensalsMutArray removeObjectAtIndex:idComensal];
    [comensalsMutArray insertObject:pagamentComensal atIndex:idComensal];
    [dinar setValue:comensalsMutArray forKey:@"comensals"];
    
    [tbDetallDinar reloadData];
    
}

#pragma mark - Teclat i format preu

-(void)amagaTeclat{
    
    if ([txfPreuTotal isFirstResponder]) {
        float preuTotal = [[txfPreuTotal.text stringByReplacingOccurrencesOfString:@"," withString:@"."]floatValue];
        [txfPreuTotal setText:[NSString stringWithFormat:@"%.02f €",preuTotal]];
        float preuPerCap = ceilf(preuTotal / [comensalsMutArray count] );
        
        [dinar setObject:[NSNumber numberWithFloat:preuPerCap] forKey:@"preuPerCap"];
        [dinar setObject:[NSNumber numberWithFloat:preuTotal] forKey:@"preuTot"];
        [tbDetallDinar reloadData];
        [txfPreuTotal resignFirstResponder];
        
    }
}

- (IBAction)pujaVista:(id)sender {
    [self mouVista:YES];
}

- (IBAction)baixaVista:(id)sender {
    
    [self mouVista:NO];
}

-(void) mouVista:(BOOL) pujaVista{
    
    const int distancia = 150;
    const float durada = 0.25f;
    
    int mou = (pujaVista ? -distancia : distancia);
    
    [UIView beginAnimations: @"animacio" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: durada];
    self.view.frame = CGRectOffset(self.view.frame, 0, mou);
    [UIView commitAnimations];
}

#pragma mark - Font etiqueta

-(CGSize)midaLabel:(NSString*)text{
    UIFont *font = fontEtiqueta;
    CGSize mida = [text sizeWithFont:font];
    return mida;
}


@end







