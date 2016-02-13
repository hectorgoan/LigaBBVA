//
//  HGAJornadaTableViewController.h
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGAJornadaTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *arrayPartidos;
    
    NSString *equiposAPasar;
    NSString *equipoLocalAPasar;
    NSString *golesEquipoLocalAPasar;
    NSString *equipoVisitanteAPasar;
    NSString *golesEquipoVisitanteAPasar;
    
}
@property (nonatomic) int miNumero;

@end
