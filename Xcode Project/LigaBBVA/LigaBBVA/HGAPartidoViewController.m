//
//  HGAPartidoViewController.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "HGAPartidoViewController.h"
#import "HGAEquipoViewController.h"

@interface HGAPartidoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoEquipoLocal;
@property (weak, nonatomic) IBOutlet UIImageView *logoEquipoVisitante;
@property (weak, nonatomic) IBOutlet UIButton *nombreEquipoLocal;
@property (weak, nonatomic) IBOutlet UIButton *nombreEquipoVisitante;
@property (weak, nonatomic) IBOutlet UILabel *marcadorEquipoLocal;
@property (weak, nonatomic) IBOutlet UILabel *marcadorEquipoVisitante;
- (IBAction)equipoLocalTocado:(id)sender;
- (IBAction)equipoVisitanteTocado:(id)sender;

@end

@implementation HGAPartidoViewController


@synthesize logoEquipoLocal;
@synthesize logoEquipoVisitante;
@synthesize nombreEquipoLocal;
@synthesize nombreEquipoVisitante;
@synthesize marcadorEquipoLocal;
@synthesize marcadorEquipoVisitante;

@synthesize tituloPartido;

@synthesize equipoLocal;
@synthesize golesEquipoLocal;
@synthesize equipoVisitante;
@synthesize golesEquipoVisitante;

- (void)viewDidLoad
{
    //Interface setup
    [nombreEquipoLocal setTitle:equipoLocal forState:UIControlStateNormal];
    [nombreEquipoVisitante setTitle:equipoVisitante forState:UIControlStateNormal];
    
    if ([golesEquipoLocal integerValue] > [golesEquipoVisitante integerValue])
    {
        //Light Green
        [nombreEquipoLocal setTitle:[NSString stringWithFormat:@"%@ 👍",equipoLocal] forState:UIControlStateNormal];
        marcadorEquipoLocal.textColor = [UIColor colorWithRed:0.22 green:0.80 blue:0.58 alpha:1.0];
        //Light Red
        [nombreEquipoVisitante setTitle:[NSString stringWithFormat:@"%@ 👎", equipoVisitante] forState:UIControlStateNormal];
        marcadorEquipoVisitante.textColor = [UIColor colorWithRed:0.80 green:0.22 blue:0.22 alpha:1.0];
    }else if ([golesEquipoLocal integerValue] < [golesEquipoVisitante integerValue])
    {
        //Light Red
        [nombreEquipoLocal setTitle:[NSString stringWithFormat:@"%@ 👎",equipoLocal] forState:UIControlStateNormal];
        marcadorEquipoLocal.textColor = [UIColor colorWithRed:0.80 green:0.22 blue:0.22 alpha:1.0];
        //Light Green
        [nombreEquipoVisitante setTitle:[NSString stringWithFormat:@"%@ 👍", equipoVisitante] forState:UIControlStateNormal];
        marcadorEquipoVisitante.textColor = [UIColor colorWithRed:0.22 green:0.80 blue:0.58 alpha:1.0];
    }else
    {
        //Light Orange
        [nombreEquipoLocal setTitle:[NSString stringWithFormat:@"%@ 😟",equipoLocal] forState:UIControlStateNormal];
        [nombreEquipoVisitante setTitle:[NSString stringWithFormat:@"%@ 😩", equipoVisitante] forState:UIControlStateNormal];
        marcadorEquipoLocal.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0.04 alpha:1.0];
        marcadorEquipoVisitante.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0.04 alpha:1.0];
    }
    
    [marcadorEquipoLocal setText:golesEquipoLocal];
    [marcadorEquipoVisitante setText:golesEquipoVisitante];
    
    
    
    
    logoEquipoLocal.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", equipoLocal]];
    logoEquipoVisitante.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",equipoVisitante]];
    
    //UIImage as button
    UITapGestureRecognizer *localPush = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(logoLocalPushed)];
    [localPush setNumberOfTapsRequired:1];
    logoEquipoLocal.userInteractionEnabled = YES;
    [logoEquipoLocal addGestureRecognizer:localPush];

    UITapGestureRecognizer *visitantePush = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(logoVisitantePushed)];
    [visitantePush setNumberOfTapsRequired:1];
    logoEquipoVisitante.userInteractionEnabled = YES;
    [logoEquipoVisitante addGestureRecognizer:visitantePush];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Reactions
-(void)logoLocalPushed
{
    [self performSegueWithIdentifier:@"equipo1ADetalle" sender:self];
}
-(void)logoVisitantePushed
{
    [self performSegueWithIdentifier:@"equipo2ADetalle" sender:self];
}

- (IBAction)equipoLocalTocado:(id)sender
{
}

- (IBAction)equipoVisitanteTocado:(id)sender
{
}


//Passing info to the detailed view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"equipo1ADetalle"])
    {
        HGAEquipoViewController *ec = [segue destinationViewController];        
        [ec setNombreEquipo:equipoLocal];
        if ([golesEquipoLocal intValue] > [golesEquipoVisitante intValue])
        {
            [ec setResultado:@"Ganador"];
            
        }else if([golesEquipoVisitante intValue] > [golesEquipoLocal intValue])
        {
            [ec setResultado:@"Perdedor"];
        }else
        {
            [ec setResultado:@"Empate"];
        }

        
    }else if([[segue identifier]isEqualToString:@"equipo2ADetalle"])
    {
        HGAEquipoViewController *ec = [segue destinationViewController];
        [ec setNombreEquipo:equipoVisitante];
        if ([golesEquipoLocal intValue] > [golesEquipoVisitante intValue])
        {
            [ec setResultado:@"Perdedor"];
        }else if([golesEquipoVisitante intValue] > [golesEquipoLocal intValue])
        {
            [ec setResultado:@"Ganador"];
        }else
        {
            [ec setResultado:@"Empate"];
        }
    }
}

@end
