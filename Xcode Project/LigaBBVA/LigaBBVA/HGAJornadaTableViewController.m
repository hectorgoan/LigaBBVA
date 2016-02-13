//
//  HGAJornadaTableViewController.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "HGAJornadaTableViewController.h"
#import "HGAPartidoViewController.h"


@interface HGAJornadaTableViewController ()

@end

@implementation HGAJornadaTableViewController
@synthesize miNumero;

- (void)viewDidLoad
{
    [self getPartidosFromJSON];
    self.title = [NSString stringWithFormat:@"Jornada %d", miNumero];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Datasource's protocol methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayPartidos count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
       
    NSDictionary *jornada;
    jornada = [arrayPartidos objectAtIndex:indexPath.row];

    
    NSString *equipos = [NSString stringWithFormat:@"%@ vs. %@",[jornada objectForKey:@"homeTeamName"], [jornada objectForKey:@"awayTeamName"]];
    NSString *fecha = [jornada objectForKey:@"date"];
    NSString *dia1 = [fecha substringFromIndex:8];
    NSString *dia = [dia1 substringToIndex:2];
    
    NSString *mes1 = [fecha substringFromIndex:5];
    NSString *mes = [mes1 substringToIndex:2];
    
    NSString *fechaAjustada = [NSString stringWithFormat:@"%@-%@", dia, mes];
    
    cell.textLabel.font = [cell.textLabel.font fontWithSize:15];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = equipos;
    
    cell.detailTextLabel.text = fechaAjustada;
    
    return cell;
}

// Utils
-(void)getPartidosFromJSON
{
    // First we prepare the http request to the server
    NSString *miURL = [NSString stringWithFormat:@"http://hectorgoan.ga/FOOTBALL/Jornadas/%dJornada.json", miNumero];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:miURL]];
    
    //Then we fill an NSData object with the JSON response
    NSData *response =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //Now let's parse it
    NSError *jsonParsingError = nil;
    
    arrayPartidos = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
}


//Perform Segue
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *jornada = [arrayPartidos objectAtIndex:indexPath.row];
    equiposAPasar = [NSString stringWithFormat:@"%@ vs. %@",[jornada objectForKey:@"homeTeamName"], [jornada objectForKey:@"awayTeamName"]];
    equipoLocalAPasar = [jornada objectForKey:@"homeTeamName"];
    equipoVisitanteAPasar = [jornada objectForKey:@"awayTeamName"];
    
    NSDictionary *result = [jornada objectForKey:@"result"];
    golesEquipoLocalAPasar = [result objectForKey:@"goalsHomeTeam"];
    golesEquipoVisitanteAPasar = [result objectForKey:@"goalsAwayTeam"];
    
    
    
    [self performSegueWithIdentifier:@"PartidosToPartidoSegue" sender:self];
}

//Passing info to the secondary views
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"PartidosToPartidoSegue"])
    {
        HGAPartidoViewController *pc = [segue destinationViewController];
        [pc setTituloPartido:equiposAPasar];
        [pc setEquipoLocal:equipoLocalAPasar];
        [pc setEquipoVisitante:equipoVisitanteAPasar];
        [pc setGolesEquipoLocal:golesEquipoLocalAPasar];
        [pc setGolesEquipoVisitante:golesEquipoVisitanteAPasar];
        
    }
}
@end
