//
//  TaulaDinarsViewController.m
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "TaulaDinarsViewController.h"


@interface TaulaDinarsViewController (){
    
    NSMutableArray *dinarsMutableArray;
    NSMutableDictionary *rootDictionary;
    UITapGestureRecognizer *gestTocaLabel;
    NSMutableArray *rectsLabelsMutArr;
    
}

@end

@implementation TaulaDinarsViewController
@synthesize tbViewDinars;


- (id)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
        
        rootDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self plistPath]];
        
        dinarsMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"dinars"]];
        
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        dinarsMutableArray = [[NSMutableArray alloc] init];
    }
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    [tbViewDinars addSubview:imgFons];
    [tbViewDinars setBackgroundView:imgFons];
    [tbViewDinars setBackgroundColor:[UIColor clearColor]];
    tbViewDinars.opaque = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actualitzaDadesNoti:) name:@"actualitzaDades" object:nil ];
    
    gestTocaLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hatocat)];
    
    rectsLabelsMutArr = [[NSMutableArray alloc] init ];
    
}

-(NSString *)plistPath{
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [rootPath stringByAppendingPathComponent:@"latalegaBD.plist"];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dinarsMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellDinars";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (dinarsMutableArray.count > 0) {
        cell.textLabel.text =nil;
        float nouIndex = (indexPath.row * -1) + [dinarsMutableArray count] - 1;
        NSMutableDictionary *dinarActualMutDict = [[NSMutableDictionary alloc] initWithDictionary:[dinarsMutableArray objectAtIndex:nouIndex]];
        NSMutableArray *comensalsMutArray = [[NSMutableArray alloc] initWithArray:[dinarActualMutDict objectForKey:@"comensals"]];
        int noHanPagat = 0;
        
        UIImageView *imgDimar = (UIImageView *)[cell viewWithTag:100];
        imgDimar.image = [UIImage imageNamed:[dinarActualMutDict objectForKey:@"imatge"]];
        
        UILabel *lbMenu = (UILabel *)[cell viewWithTag:101];
        [lbMenu setText:[dinarActualMutDict objectForKey:@"menu"]];
        
        UILabel *lbData = (UILabel *)[cell viewWithTag:102];
        lbData.text = [dinarActualMutDict objectForKey:@"data"];
        
        UILabel *lbPreu = (UILabel *)[cell viewWithTag:103];
        float preuPerCap = [[dinarActualMutDict objectForKey:@"preuPerCap"] floatValue];
        lbPreu.text = [NSString stringWithFormat:@"%.02f €",preuPerCap];
        //lbPreu.text = [dinarActualMutDict objectForKey:@"preuCap"];
        
        UILabel *lbComensals = (UILabel *)[cell viewWithTag:104];
        lbComensals.text = [NSString stringWithFormat:@"%i comensals",[comensalsMutArray count]];

        for (int i=0; i < comensalsMutArray.count; i++) {
            NSDictionary *comensalDict = [[NSDictionary alloc] initWithDictionary:[comensalsMutArray objectAtIndex:i]];
            
            float pagat = [[comensalDict objectForKey:@"pagat"] floatValue];
            
            if (pagat < preuPerCap) {
                noHanPagat++;
            }
        }
        UILabel *lbNoHanPagat = (UILabel *)[cell viewWithTag:106];
        UIImageView *imgCercle = (UIImageView *)[cell viewWithTag:105];
        if (noHanPagat > 0) {
            
            lbNoHanPagat.text = [NSString stringWithFormat:@"%i",noHanPagat];
            lbNoHanPagat.hidden = NO;
            imgCercle.hidden = NO;
            
        }else{
            lbNoHanPagat.hidden = YES;
            imgCercle.hidden = YES;
        }
        cell.tag = nouIndex;
    }
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dinarsMutableArray count]>0) {
        
        float nouIndex = (indexPath.row * -1) + [dinarsMutableArray count] - 1;
        [dinarsMutableArray removeObjectAtIndex:nouIndex];
        [rootDictionary setObject:dinarsMutableArray forKey:@"dinars"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
        
        [tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UITableViewCell *cell = (UITableViewCell *)sender;

    if ([segue.identifier isEqualToString:@"GoToDetallDinar"]) {
        DetallDinarVC *detallDinarVC = (DetallDinarVC*)segue.destinationViewController;
        [detallDinarVC setDinar:[dinarsMutableArray objectAtIndex:cell.tag]];
        [detallDinarVC setIdDinar:cell.tag];
    }
}

#pragma mark - Metodes delegat

-(void)actualitzaDadesNoti:(NSObject *)object {
    
    [rootDictionary removeAllObjects];
    [dinarsMutableArray removeAllObjects];
    rootDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self plistPath]];
    dinarsMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"dinars"]];
    [self.tableView reloadData];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end










