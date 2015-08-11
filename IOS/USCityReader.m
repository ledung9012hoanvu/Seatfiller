//
//  USCityReader.m
//  SeatFillers
//
//  Created by LeDung on 6/15/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "USCityReader.h"
#import "AppDelegate.h"

@implementation EventCity

@end


@implementation USCityReader 
+(instancetype)sharedClient
{
    NSLog(@"share client");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"USCity" ofType:@"csv"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    static USCityReader *usCityReader =nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^
                   {
                       if(usCityReader ==nil)
                       {
                           usCityReader  = [[USCityReader alloc] initWithCSVString:content];
                           [usCityReader setDelegate:usCityReader];

                           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                               [usCityReader parse];
                           });
                       };
                   });
    return usCityReader;
}

-(void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    NSArray *arrar =[field componentsSeparatedByString:@"|"];
    if(arrar.count >1)
    {
        AppDelegate *app =[[UIApplication sharedApplication]delegate];
        NSArray *keys =[app.dictionaryCiteState allKeys];
        if(keys.count==0)
        {
            NSMutableArray *firstArray =[NSMutableArray arrayWithObject:arrar[2]];
            [app.dictionaryCiteState setObject:firstArray forKey:arrar[1]];
        }
        else
        {
            BOOL isNew =YES;
            for(int i = 0 ; i<keys.count; i++)
            {
                if([keys[i] isEqualToString:arrar[1]])
                {
                    NSMutableArray *show =[app.dictionaryCiteState objectForKey:arrar[1]];
                    [show addObject:arrar[2]];
                    [app.dictionaryCiteState setObject:show forKey:arrar[1]];
                    isNew =NO;
                    break;
                }
            }
            if(isNew)
            {
                NSMutableArray *firstArray =[NSMutableArray arrayWithObject:arrar[2]];
                [app.dictionaryCiteState setObject:firstArray forKey:arrar[1]];
            }

        }
    }
}

-(void)parserDidEndDocument:(CHCSVParser *)parser
{
    AppDelegate *app =[[UIApplication sharedApplication]delegate];
    NSLog(@"dictionary : %D",[[app.dictionaryCiteState allKeys]count ]);
}


@end
