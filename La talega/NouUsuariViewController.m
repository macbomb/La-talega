//
//  NouUsuariViewController.m
//  La talega
//
//  Created by Macbomb on 18/02/13.
//  Copyright (c) 2013 MACorts. All rights reserved.
//

#import "NouUsuariViewController.h"

@interface NouUsuariViewController (){
    
    NSMutableArray *usuarisArray;
}

@end

@implementation NouUsuariViewController

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
    
    usuarisArray = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btOk:(id)sender {
    
    NSString *nomSenseEspaisDavant = [_nomTexF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (nomSenseEspaisDavant.length  > 0) {
        
        [usuarisArray addObject:nomSenseEspaisDavant];
        _lbUltimNom.text = nomSenseEspaisDavant;
        _lbTotalNoms.text = [NSString stringWithFormat:@"%i",usuarisArray.count];
    }
    _nomTexF.text = @"";
    
    
}

- (IBAction)guardaUsuarisNous:(UIBarButtonItem *)sender {
    [self.delegate introNousUsuaris:usuarisArray];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btTorna:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Gestion teclado

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_nomTexF isFirstResponder] && [touch view] != _nomTexF) {
        [_nomTexF resignFirstResponder];
    }
}

@end
