//
//  TaulaUsuarisViewControler.m
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "TaulaUsuarisViewControler.h"

@interface TaulaUsuarisViewControler (){
    
    NSMutableArray *usuarisMutableArray;
    NSMutableDictionary *rootDictionary;
    
}

@end

@implementation TaulaUsuarisViewControler
@synthesize tbViewUsuaris;

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
        
        usuarisMutableArray = [[NSMutableArray alloc] initWithArray:[rootDictionary objectForKey:@"usuaris"]];
    }else{
        rootDictionary = [[NSMutableDictionary alloc] init];
        usuarisMutableArray = [[NSMutableArray alloc] init];
    }
    
    UIImageView *imgFons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    [tbViewUsuaris addSubview:imgFons];
    [tbViewUsuaris setBackgroundView:imgFons];
    [tbViewUsuaris setBackgroundColor:[UIColor clearColor]];
    tbViewUsuaris.opaque = NO;

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
    if (usuarisMutableArray.count < 1) {
        return 1;
    }else{
        return usuarisMutableArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellUser";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (usuarisMutableArray.count < 1) {
        
        cell.textLabel.text = @"No hi ha cap comensal";
    }else{
        cell.textLabel.text = [usuarisMutableArray objectAtIndex:indexPath.row];
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
    if ([usuarisMutableArray count]>0) {
        
        [usuarisMutableArray removeObjectAtIndex:indexPath.row];
        [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
        if (plistData) {
            [plistData writeToFile:[self plistPath] atomically:YES];
        }
        [tableView reloadData];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"GoToNouUsuari"]) {
        NouUsuariViewController * nouUsuariViewControler = (NouUsuariViewController*)segue.destinationViewController;
        nouUsuariViewControler.delegate = self;
    }
}

- (IBAction)tornaInici:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Metodo delegado

-(void)introNousUsuaris:(NSArray*)usuarisNous{
    
    for (int i = 0; i < usuarisNous.count; i++) {
        [usuarisMutableArray addObject:[usuarisNous objectAtIndex:i]];
        [self.tableView reloadData];
    }
    
    [rootDictionary setObject:usuarisMutableArray forKey:@"usuaris"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:rootDictionary format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    if (plistData) {
        [plistData writeToFile:[self plistPath] atomically:YES];
    }
    
}

@end









