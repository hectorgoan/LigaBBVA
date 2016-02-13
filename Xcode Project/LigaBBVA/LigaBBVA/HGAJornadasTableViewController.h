//
//  HGAJornadasTableViewController.h
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import <UIKit/UIKit.h>


//UITableViewDataSource -> Link between data and table view. Methods needed: (tableView:cellForRowAtIndexPath) & (tableView:numberOfRowsInSection)
//UITableViewDelegate -> Deals with the appearance of the table view (height, sections heading and footers, etc, etc)
@interface HGAJornadasTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *arrayJornadas;
    int numJornadaAPasar;
    
    NSMutableDictionary *mesJornada;
    NSMutableDictionary *jornadaMes;
    NSMutableArray *secciones;
    NSDictionary *valorNumericoSecciones;
    NSMutableArray *seccionesValor;
    NSMutableArray *SECCIONESbueno;
    

    NSMutableArray *Enero;
    NSMutableArray *Febrero;
    NSMutableArray *Marzo;
    NSMutableArray *Abril;
    NSMutableArray *Mayo;
    NSMutableArray *Junio;
    NSMutableArray *Julio;
    NSMutableArray *Agosto;
    NSMutableArray *Septiembre;
    NSMutableArray *Octubre;
    NSMutableArray *Noviembre;
    NSMutableArray *Diciembre;
    


}

@end
