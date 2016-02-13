//
//  HGAJornadasTableViewController.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "HGAJornadasTableViewController.h"
#import "HGAJornadaTableViewController.h"
#import "HGAAppDelegate.h"

@interface HGAJornadasTableViewController ()

@end

@implementation HGAJornadasTableViewController

- (void)viewDidLoad
{
    HGAAppDelegate *appDelegate = (HGAAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.aCambiar = self.navigationController.navigationBar;
    // Let's parse some JSON
    [self getJornadasFromJSON];
    mesJornada = [[NSMutableDictionary alloc]initWithCapacity:[arrayJornadas count]];
    jornadaMes = [[NSMutableDictionary alloc]initWithCapacity:[arrayJornadas count]];
    secciones = [[NSMutableArray alloc]init];
    valorNumericoSecciones = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"Enero",@"2",@"Febrero",@"3",@"Marzo",@"4",@"Abril",@"5",@"Mayo",@"6",@"Junio",@"7",@"Julio",@"8",@"Agosto",@"9",@"Septiembre",@"10",@"Octubre",@"11",@"Noviembre",@"12",@"Diciembre", nil];
    seccionesValor = [[NSMutableArray alloc]init];
    SECCIONESbueno = [[NSMutableArray alloc]init];
    
    Enero = [[NSMutableArray alloc]init];
    Febrero = [[NSMutableArray alloc]init];
    Marzo = [[NSMutableArray alloc]init];
    Abril = [[NSMutableArray alloc]init];
    Mayo = [[NSMutableArray alloc]init];
    Junio = [[NSMutableArray alloc]init];
    Julio = [[NSMutableArray alloc]init];
    Agosto = [[NSMutableArray alloc]init];
    Septiembre = [[NSMutableArray alloc]init];
    Octubre = [[NSMutableArray alloc]init];
    Noviembre = [[NSMutableArray alloc]init];
    Diciembre = [[NSMutableArray alloc]init];
    [self extraerCategorias];
    [self rellenaArraysMeses];
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Datasource's protocol methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num = 0;
    
    for (NSString* key in jornadaMes)
    {
        NSString *value = [jornadaMes objectForKey:key];
        // do stuff
        
        if ([value isEqualToString:[SECCIONESbueno objectAtIndex:section]])
        {
            num = num+1;
            //NSLog(@"%@",value);
        }

    }
    
    NSInteger numeroq = (NSInteger) num;
    return numeroq;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [SECCIONESbueno count]; //From August to May
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [SECCIONESbueno objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {

        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    
    
    NSDictionary *jornada;
    int mes = indexPath.section;
    NSString *miMes = [SECCIONESbueno objectAtIndex:mes];
    
    
    if ([miMes isEqualToString:@"Enero"])
    {
        jornada = [Enero objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Febrero"])
    {
        jornada = [Febrero objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Marzo"])
    {
        jornada = [Marzo objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Abril"])
    {
        jornada = [Abril objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Mayo"])
    {
        jornada = [Mayo objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Junio"])
    {
        jornada = [Junio objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Julio"])
    {
        jornada = [Julio objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Agosto"])
    {
        jornada = [Agosto objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Septiembre"])
    {
        jornada = [Septiembre objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Octubre"])
    {
        jornada = [Octubre objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Noviembre"])
    {
        jornada = [Noviembre objectAtIndex:indexPath.row];
    }else if ([miMes isEqualToString:@"Diciembre"])
    {
        jornada = [Diciembre objectAtIndex:indexPath.row];
    }
    
    //Let's beautify it

    NSString *numeroJornada = [NSString stringWithFormat:@"%@",[jornada objectForKey:@"Fecha"]];
    
    NSString *fechaJornada = [NSString stringWithFormat:@"nº %@", [jornada objectForKey:@"NumJornada"]];
    
    cell.textLabel.text = numeroJornada;
    cell.detailTextLabel.text = fechaJornada;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithRed:0.400 green:0.149 blue:0.486 alpha:1.00];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}

// Utils
-(void)getJornadasFromJSON
{
    // First we prepare the http request to the server
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hectorgoan.ga/FOOTBALL/misJornadas.json"]];
    
    //Then we fill an NSData object with the JSON response
    NSData *response =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //Now let's parse it
    NSError *jsonParsingError = nil;
    
    arrayJornadas = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];

    
}

-(void)extraerCategorias
{
    for (int i=0; i < [arrayJornadas count]; i++)
    {
        NSDictionary *jornadaAExaminar = [arrayJornadas objectAtIndex:i];
        
        NSString *mes = [jornadaAExaminar objectForKey:@"Mes"];
        NSString *numJornada = [jornadaAExaminar objectForKey:@"NumJornada"];
        
        [mesJornada setObject:numJornada forKey:mes];
        [jornadaMes setObject:mes forKey:numJornada];
    }
    for (int j=0; j< [mesJornada count]; j++)
    {
        for (NSString* key in mesJornada)
        {
            NSString *value = [mesJornada objectForKey:key];
            // do stuff
            if (![secciones containsObject:key])
            {
                [secciones addObject:key];
            }
        }
        
    }
    for (int i=0; i<[secciones count]; i++)
    {
        //NSLog(@"%d %@ %@", i, [secciones objectAtIndex:i], [valorNumericoSecciones objectForKey:[secciones objectAtIndex:i]]);
        [seccionesValor addObject:[valorNumericoSecciones objectForKey:[secciones objectAtIndex:i]]];
    }
    int flag = 8;
    while ([SECCIONESbueno count] < [secciones count] )
    {
        for (int i=0; i<[secciones count]; i++)
        {
            if ([[seccionesValor objectAtIndex:i] integerValue] == flag)
            {
                [SECCIONESbueno addObject:[secciones objectAtIndex:i]];
                flag = flag+1;
            }else if (flag == 13)
            {
                flag = 1;
            }
            
        }
    }

    
}

-(void)rellenaArraysMeses
{
    for (int i=0; i<[arrayJornadas count]; i++)
    {
        NSDictionary *jornada = [arrayJornadas objectAtIndex:i];
        // do stuff
        if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Enero"])
        {
            [Enero addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Febrero"])
        {
            [Febrero addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"]isEqualToString:@"Marzo"])
        {
            [Marzo addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Abril"])
        {
            [Abril addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Mayo"])
        {
            [Mayo addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Junio"])
        {
            [Junio addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Julio"])
        {
            [Julio addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Agosto"])
        {
            [Agosto addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Septiembre"])
        {
            [Septiembre addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Octubre"])
        {
            [Octubre addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Noviembre"])
        {
            [Noviembre addObject:jornada];
        }else if ([[jornada objectForKey:@"Mes"] isEqualToString:@"Diciembre"])
        {
            [Diciembre addObject:jornada];
        }
    }
}

//Perform Segue
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int mes = indexPath.section;
    NSString *miMes = [SECCIONESbueno objectAtIndex:mes];
    int arrastrado = 0;
    
    //The league always start in August
    
    if ([miMes isEqualToString:@"Enero"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count];
        numJornadaAPasar = indexPath.row;
    }else if ([miMes isEqualToString:@"Febrero"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count] + [Enero count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Marzo"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count] + [Enero count] + [Febrero count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Abril"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count] + [Enero count] + [Febrero count] + [Marzo count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Mayo"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count] + [Enero count] + [Febrero count] + [Marzo count] + [Abril count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Junio"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count] + [Enero count] + [Febrero count] + [Marzo count] + [Abril count] + [Mayo count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Julio"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count] + [Diciembre count] + [Enero count] + [Febrero count] + [Marzo count] + [Abril count] + [Mayo count] + [Junio count];

        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Agosto"])    //League starts here
    {
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Septiembre"])
    {
        arrastrado = arrastrado + [Agosto count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Octubre"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Noviembre"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }else if ([miMes isEqualToString:@"Diciembre"])
    {
        arrastrado = arrastrado + [Agosto count] + [Septiembre count] + [Octubre count] + [Noviembre count];
        numJornadaAPasar = indexPath.row + arrastrado;
    }

    
    [self performSegueWithIdentifier:@"JornadaToPartidosSegue" sender:self];
}
//Passing info to the secondary views
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"JornadaToPartidosSegue"])
    {
        HGAJornadaTableViewController *jc = [segue destinationViewController];
        [jc setMiNumero:numJornadaAPasar+1];
        
    }
}

@end
