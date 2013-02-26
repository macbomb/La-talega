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
    
}

@end

@implementation TaulaDinarsViewController
@synthesize tbViewDinars;

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
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
        
        rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[self plistPath]];
        
        dinarsMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"dinars"]];
        //NSLog([self plistPath]);
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        dinarsMutableArray = [[NSMutableArray alloc] init];
    }
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    [tbViewDinars addSubview:imgFons];
    [tbViewDinars setBackgroundView:imgFons];
    [tbViewDinars setBackgroundColor:[UIColor clearColor]];
    tbViewDinars.opaque = NO;
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.

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
        
        for (int i=0; i < comensalsMutArray.count; i++) {
            NSDictionary *comensalDict = [[NSDictionary alloc] initWithDictionary:[comensalsMutArray objectAtIndex:i]];
            NSString *haPagat = [comensalDict objectForKey:@"pagat"] ;
            if ([haPagat isEqualToString:@"NO"] ){
                noHanPagat++;
            }
        }
        
//        UIImageView *imgDimar = (UIImageView *)[cell viewWithTag:100];
//        imgDimar.image = [UIImage imageNamed:[dinarActualMutDict objectForKey:@"imatge"]];
        
        UILabel *lbMenu = (UILabel *)[cell viewWithTag:101];
        [lbMenu setText:[dinarActualMutDict objectForKey:@"menu"]];
        
        UILabel *lbData = (UILabel *)[cell viewWithTag:102];
        lbData.text = [dinarActualMutDict objectForKey:@"data"];
        
        UILabel *lbPreu = (UILabel *)[cell viewWithTag:103];
        NSNumber *preuCapNum = [dinarActualMutDict objectForKey:@"preuCap"];
        float preuCapInt = [preuCapNum intValue];
        NSString *preuPerCap = [NSString stringWithFormat:@"%.02f €",preuCapInt];
        lbPreu.text = preuPerCap;
        //lbPreu.text = [dinarActualMutDict objectForKey:@"preuCap"];
        
        UILabel *lbComensals = (UILabel *)[cell viewWithTag:104];
        lbComensals.text = [NSString stringWithFormat:@"%i comensals",[comensalsMutArray count]];
        
        if (noHanPagat > 0) {
            
            UILabel *lbNoHanPagat = (UILabel *)[cell viewWithTag:106];
            lbNoHanPagat.text = [NSString stringWithFormat:@"%i",noHanPagat];
            lbNoHanPagat.hidden = NO;
            UIImageView *imgCercle = (UIImageView *)[cell viewWithTag:105];
            imgCercle.hidden = NO;
            
        }
        cell.tag = indexPath.row;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dinarsMutableArray count]>0) {
        [dinarsMutableArray removeObjectAtIndex:indexPath.row];
        [rootDictionary setObject:dinarsMutableArray forKey:@"dinars"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
        
        [tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"GoToNouDinarVC"]) {
        NouDinarVC *nouDinarVC = (NouDinarVC*)segue.destinationViewController;
        nouDinarVC.delegate = self;
        
    }
}

#pragma mark - Metodes delegat

-(void)introNouDinar:(NSDictionary *)dinarNou{
    
    [dinarsMutableArray addObject:dinarNou];
    [rootDictionary setObject:dinarsMutableArray forKey:@"dinars"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    if (plistData) {
        [plistData writeToFile:[self plistPath] atomically:YES];
    }
    
    [self.tableView reloadData];
}

-(void)recargaTaulaDinars{
    
}

@end










