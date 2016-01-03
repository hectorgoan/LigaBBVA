//
//  main.m
//  JSONparser
//
//  Created by Héctor Gonzalo Andrés on 3/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // Let's parse some JSON
        
        // First we prepare the http request to the server
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hectorgoan.me/FOOTBALL/misJornadas.json"]];
        
        //Then we fill an NSData object with the JSON response
        NSData *response =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        //Now let's parse it
        NSError *jsonParsingError = nil;
        
        NSArray *arrayJornadas = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
        
        
        NSDictionary *jornada;
        
        for (int i=0; i<[arrayJornadas count]; i++)
        {
            jornada = [arrayJornadas objectAtIndex:i];
            NSLog(@"-");
            NSLog(@"%@",[jornada objectForKey:@"NumJornada"]);
            NSLog(@"%@",[jornada objectForKey:@"Mes"]);
            NSLog(@"%@",[jornada objectForKey:@"Fecha"]);
            NSLog(@"-");
        }
    }
    return 0;
}
