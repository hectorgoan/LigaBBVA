//
//  HGAJugadoresTableViewController.h
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 5/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGAJugadoresTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *arrayJugadores;
    NSDictionary *diccionario;

}

@property (nonatomic) NSString *nombreEquipo;


@end
