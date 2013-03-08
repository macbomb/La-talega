//
//  PagamentsVC.m
//  La talega
//
//  Created by Macbomb on 05/03/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "PagamentsVC.h"

@interface PagamentsVC (){
    float preuPerCap;
    float pagat;
}

@end

@implementation PagamentsVC

@synthesize comensalDict, lbData, lbNom, txfQuantitat, btCancel, btNoHaPagat, btPagat;

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
    lbData.text = [comensalDict objectForKey:@"data"];
    lbNom.text  = [comensalDict objectForKey:@"nomComensal"];
    pagat = [[comensalDict objectForKey:@"pagat"] floatValue];
    
    preuPerCap = [[comensalDict objectForKey:@"preuPerCap"] floatValue];
    [txfQuantitat setText:[NSString stringWithFormat:@"%.02f €",preuPerCap - pagat]];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(amagaTeclat)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [comensalDict removeObjectForKey:@"data"];
    [comensalDict removeObjectForKey:@"preuPerCap"];
    if (preuPerCap > 0 && pagat == preuPerCap) {
        btNoHaPagat.hidden = NO;
    }else{
        btNoHaPagat.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)amagaTeclat{
    
    if ([txfQuantitat isFirstResponder]) {
        NSString *senseEspais = [txfQuantitat.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (senseEspais.length > 0) {
            float preuAPagar = [[txfQuantitat.text stringByReplacingOccurrencesOfString:@"," withString:@"."]floatValue];
            
            if (preuAPagar > (preuPerCap - pagat)) {
                [txfQuantitat setText:[NSString stringWithFormat:@"%.02f €",preuPerCap - pagat]];
                
            }else{
                [txfQuantitat setText:[NSString stringWithFormat:@"%.02f €",preuAPagar]];
            }
            [txfQuantitat resignFirstResponder];
        }
    }
}

- (IBAction)paga:(id)sender {
    
    float preuPagat = [txfQuantitat.text floatValue];
    
    [comensalDict setObject:[NSNumber numberWithFloat:preuPagat + pagat] forKey:@"pagat"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"actualitzaPagaments" object:self userInfo:comensalDict];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancela:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)noPaga:(id)sender {
    
    [comensalDict setObject:[NSNumber numberWithFloat:0.0f] forKey:@"pagat"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"actualitzaPagaments" object:self userInfo:comensalDict];
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end





