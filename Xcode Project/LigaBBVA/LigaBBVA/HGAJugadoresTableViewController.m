//
//  HGAJugadoresTableViewController.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 5/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "HGAJugadoresTableViewController.h"

@interface HGAJugadoresTableViewController ()

@end

@implementation HGAJugadoresTableViewController

@synthesize nombreEquipo;



- (void)viewDidLoad
{
    [self getJugadoresFromJSON];
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Datasource's protocol methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayJugadores count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    
    
    NSDictionary *jugador;
    jugador = [arrayJugadores objectAtIndex:indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [jugador objectForKey:@"name"];
    if ([[jugador objectForKey:@"jerseyNumber"]isEqualToString:@"null"])
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Desconocido"];
    }else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 👕",[jugador objectForKey:@"jerseyNumber"]];
    }

    
    return cell;
}

// Utils
-(void)getJugadoresFromJSON
{
    // First we prepare the http request to the server
    
    //Filter
    // " " -> "_"
    NSString *miCarpeta = [nombreEquipo stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    // áéíóú -> aeiou
    miCarpeta = [miCarpeta stringByReplacingOccurrencesOfString:@"á" withString:@"a"];
    miCarpeta = [miCarpeta stringByReplacingOccurrencesOfString:@"é" withString:@"e"];
    miCarpeta = [miCarpeta stringByReplacingOccurrencesOfString:@"í" withString:@"i"];
    miCarpeta = [miCarpeta stringByReplacingOccurrencesOfString:@"ó" withString:@"o"];
    miCarpeta = [miCarpeta stringByReplacingOccurrencesOfString:@"ú" withString:@"u"];

    
    NSString *miUrl = [NSString stringWithFormat:@"http://hectorgoan.ga/FOOTBALL/Equipos/%@/players.json", miCarpeta];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:miUrl]];
    
    //Then we fill an NSData object with the JSON response
    NSData *response =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //Now let's parse it
    NSError *jsonParsingError = nil;
    
    arrayJugadores = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    
}

@end
