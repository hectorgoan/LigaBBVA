//
//  HGAEquipoViewController.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "HGAEquipoViewController.h"
#import "HGAJugadoresTableViewController.h"


@interface HGAEquipoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *escudoImage;
@property (weak, nonatomic) IBOutlet UILabel *resultadoLabel;
- (IBAction)botonVerJugadores:(id)sender;

@end

@implementation HGAEquipoViewController

@synthesize nombreEquipo;
@synthesize resultado;

@synthesize nombreLabel;
@synthesize escudoImage;
@synthesize resultadoLabel;

- (void)viewDidLoad
{
    
    if ([resultado isEqualToString:@"Ganador"])
    {
        //Light Green
        resultadoLabel.textColor = [UIColor colorWithRed:0.22 green:0.80 blue:0.58 alpha:1.0];
        [resultadoLabel setText:[NSString stringWithFormat:@"%@ 😁", resultado]];
        anterior = [self.navigationController.navigationBar barTintColor];
        vengoDeJornadas = YES;
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.22 green:0.80 blue:0.58 alpha:1.0]];
        
        
    }else if([resultado isEqualToString:@"Perdedor"])
    {
        //Light Red
        resultadoLabel.textColor = [UIColor colorWithRed:0.80 green:0.22 blue:0.22 alpha:1.0];
        [resultadoLabel setText:[NSString stringWithFormat:@"%@ 😭", resultado]];
        anterior = [self.navigationController.navigationBar barTintColor];
        vengoDeJornadas = YES;
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.80 green:0.22 blue:0.22 alpha:1.0]];
    }else if([resultado isEqualToString:@"Empate"])
    {
        //Light Orange
        resultadoLabel.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0.04 alpha:1.0];
        [resultadoLabel setText:[NSString stringWithFormat:@"%@ 😩", resultado]];
        anterior = [self.navigationController.navigationBar barTintColor];
        vengoDeJornadas = YES;
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.88 green:0.42 blue:0.04 alpha:1.0]];

    }
    
    [nombreLabel setText:nombreEquipo];
    escudoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", nombreEquipo]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        // Will change navigation bar color only if we came from "Jornadas" section
        if (vengoDeJornadas == YES)
        {
            [self.navigationController.navigationBar setBarTintColor:anterior];
        }
    }
    [super viewWillDisappear:animated];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if(self.navigationController == viewController) {
        return NO;
    }
    return YES;
}

//Passing info to the detail view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"teamToListOfPlayers"])
    {
        HGAJugadoresTableViewController *jc = [segue destinationViewController];
        [jc setNombreEquipo:nombreEquipo];       
        
    }
}


- (IBAction)botonVerJugadores:(id)sender
{
}
@end
