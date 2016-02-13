//
//  HGATeamsTableViewController.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "HGATeamsTableViewController.h"
#import "HGAEquipoViewController.h"

@interface HGATeamsTableViewController ()

@end

@implementation HGATeamsTableViewController

- (void)viewDidLoad
{
    [self getEquiposFromJSON];
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
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
    return [arrayEquipos count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    
    NSDictionary *equipo;
    equipo = [arrayEquipos objectAtIndex:indexPath.row];
    NSString *nombreEquipo = [equipo objectForKey:@"name"];
    cell.textLabel.text = nombreEquipo;
    
    //THUMBNAIL -> Extracted from the apple example project "LazyTableImages"
    // I was using this instead
    //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",nombreEquipo]];
    // But icons looked ugly
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@.png",nombreEquipo]];
    UIImage *thumbnail = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    if (thumbnail == nil) {
        thumbnail = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",nombreEquipo]] ;
    }
    
    CGSize itemSize = CGSizeMake(20, 25);
    //Those icons looked ugly before this quick (y un poco guarro) fix
    if ([nombreEquipo isEqualToString:@"Getafe CF"] || [nombreEquipo isEqualToString:@"Real Sociedad de Fútbol"])
    {
        itemSize = CGSizeMake(20, 20);
    }
    
        
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [thumbnail drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    

    
    return cell;
}

// Utils
-(void)getEquiposFromJSON
{
    // First we prepare the http request to the server

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hectorgoan.ga/FOOTBALL/misEquipos.json"]];
    
    //Then we fill an NSData object with the JSON response
    NSData *response =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //Now let's parse it
    NSError *jsonParsingError = nil;
    
    arrayEquipos = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
}

//Perform Segue
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *equipoAPasar = [arrayEquipos objectAtIndex:indexPath.row];
    nombreAPasar = [equipoAPasar objectForKey:@"name"];
    
    [self performSegueWithIdentifier:@"listOfTeamsToTeam" sender:self];
}
//Passing info to the secondary views
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"listOfTeamsToTeam"])
    {
        HGAEquipoViewController *ec = [segue destinationViewController];
        
        [ec setNombreEquipo:nombreAPasar];
        
    }
}


@end
