//
//  HGATeamsTableViewController.h
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 4/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGATeamsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arrayEquipos;
    
    NSString *nombreAPasar;
}

@end
