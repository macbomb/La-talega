//
//  DetallDinarsTbViewControler.m
//  La talega
//
//  Created by Macbomb on 04/03/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "DetallDinarsTbViewControler.h"

@interface DetallDinarsTbViewControler (){
    
    NSMutableArray *dinarsMutableArray;
    NSMutableDictionary *rootDictionary;
    NSMutableArray *comensalsMutArray;
    NSDictionary *dinarActualDict;
    
    UITextField *txfPreuTotal;
}

@end

@implementation DetallDinarsTbViewControler

@synthesize tbDetallDinar;

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
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(amagaTeclat)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    [tbDetallDinar addSubview:imgFons];
    [tbDetallDinar setBackgroundView:imgFons];
    [tbDetallDinar setBackgroundColor:[UIColor clearColor]];
    tbDetallDinar.opaque = NO;
    
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
            return 1;
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
    
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellDinar];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellDinar];
            }
            lbdata = (UILabel *)[cell viewWithTag:120];
            lbdata.text = [dinarActualDict objectForKey:@"data"];
            break;
        case 1:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellPreu];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellPreu];
            }
            
            txfPreuTotal = (UITextField *)[cell viewWithTag:124];
            float preuTotal = 0.00;
            txfPreuTotal.placeholder = [NSString stringWithFormat:@"%.02f €",preuTotal];
            txfPreuTotal.delegate = self;
            break;
        default:
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellComensal forIndexPath:indexPath];
            
            break;
    }
    
    // Configure the cell...
    
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

- (IBAction)btCancelPush:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)amagaTeclat{
    
    if ([txfPreuTotal isFirstResponder]) {
        float preuTotal = [txfPreuTotal.text floatValue];
        [txfPreuTotal setText:[NSString stringWithFormat:@"%.02f €",preuTotal]];
        [txfPreuTotal resignFirstResponder];
    }
}

-(void)setDinar:(NSDictionary *)dinar{
    dinarActualDict = [[NSDictionary alloc]initWithDictionary:dinar];
}

@end
