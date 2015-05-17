//
//  arduinoFan.m
//  MacFan
//
//  Created by David Paquette on 5/19/13.
//  Copyright (c) 2013 David Paquette. All rights reserved.
//

#import "arduinoFan.h"


@implementation arduinoFan

- (id)init
{
    self = [super init];
    if (self)
    {
        countError = 0;
        connected = false;
        startUp = 0;
        
    }
    return self;
}


    -(void)updateReadings{
        NSString* link = ipAddress;
     request = [NSURLRequest requestWithURL:[NSURL URLWithString:link] cachePolicy:0 timeoutInterval:4];
        NSURLResponse* response=nil;
        NSError* error=nil;
        NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    }



-(void)testConnection {
    
    if(html) {
        NSRange r = [html rangeOfString:@"color:white;'>"];
        
        if (r.location != NSNotFound) {
            
            NSRange r1 = [html rangeOfString:@"&degF</a>"];
            
            if (r1.location != NSNotFound) {
                
                if (r1.location > r.location) {
                    
                    NSString *title = [html substringWithRange:NSMakeRange(NSMaxRange(r), r1.location - NSMaxRange(r))];
                    title = [title stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
countError = 0;
                    connected = true;
                }
            }
            
        }
    
        else{
            if(countError == 0) {

                                  
                countError = 1;

                
                
            }
        }
    
}
}

-(void) SetIPAddress:(NSString *)ip{
    ipAddress = [@"http://" stringByAppendingString:ip];
    ipAddress = [ipAddress stringByAppendingString:@"/"];
    
    onIP = [ipAddress stringByAppendingString:@"?on"];
    offIP = [ipAddress stringByAppendingString:@"?off"];
    autoIP = [ipAddress stringByAppendingString:@"?auto"];
    
    statIP = [@"<a href='" stringByAppendingString:ipAddress];
    statIP = [statIP stringByAppendingString:@"?on'><button>"];
    
    
}
-(NSString*)getTemp {
       
    if(html) {
        NSRange r = [html rangeOfString:@"color:white;'>"];
        
        if (r.location != NSNotFound) {
            
            NSRange r1 = [html rangeOfString:@"&degF</a>"];
            
            if (r1.location != NSNotFound) {
                
                if (r1.location > r.location) {
                    
                    NSString *title = [html substringWithRange:NSMakeRange(NSMaxRange(r), r1.location - NSMaxRange(r))];
                    title = [title stringByTrimmingCharactersInSet:
                                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    //NSString *deg = @" °F";
                    //title = [title stringByAppendingString:deg];
                    currentTemp = title;
                }
            }
            
            }
    }


    return currentTemp;
    
}

-(NSString*)getStatus {
    

    
    if(html) {
 
        NSRange r = [html rangeOfString:@"Status:"];
        
        if (r.location != NSNotFound) {
            
            NSRange r1 = [html rangeOfString:statIP];
            
            if (r1.location != NSNotFound) {
                
                if (r1.location > r.location) {
                    
                    NSString *title = [html substringWithRange:NSMakeRange(NSMaxRange(r), r1.location - NSMaxRange(r))];
                   
                    title = [title substringToIndex:[title length] - 8];
                
                    
                   
                    currentStatus = title;
                   
                }
            }
            
        }
    }

    return currentStatus;
}

-(void)fanON {
    if(countError == 0) {
      
        NSString* link = onIP;
        NSURLResponse* response=nil;
        NSError* error=nil;
         request = [NSURLRequest requestWithURL:[NSURL URLWithString:link] cachePolicy:0 timeoutInterval:1];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    }
}

-(void)fanOFF {
    if(countError == 0) {
        NSString* link = offIP;
        NSURLResponse* response=nil;
        NSError* error=nil;
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:link] cachePolicy:0 timeoutInterval:1];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    }
    
}

-(void)fanAUTO {
    if(countError == 0) {
        NSString* link = autoIP;
        NSURLResponse* response=nil;
        NSError* error=nil;
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:link] cachePolicy:0 timeoutInterval:1];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    }
}

-(double)getDoubTemp{
    
    [self getTemp];
    numbTemp = [currentTemp doubleValue];
    return (numbTemp);
}



-(NSString*)maxTemp {
    
  
    
    if(html) {
        NSRange r = [html rangeOfString:@"Max Temp:"];
        
        if (r.location != NSNotFound) {
            
            NSRange r1 = [html rangeOfString:@"</FONT>"];
            
            if (r1.location != NSNotFound) {
                
                if (r1.location > r.location) {
                    
                    NSString *title = [html substringWithRange:NSMakeRange(NSMaxRange(r), r1.location - NSMaxRange(r))];
                    title = [title stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    //NSString *deg = @" °F";
                    //title = [title stringByAppendingString:deg];
                    currentTemp = title;
                    
                }
            }
            
        }
    }
    return currentTemp;
    
}



-(NSString*)minTemp {
    

    
    if(html) {
        NSRange r = [html rangeOfString:@"Min Temp:"];
        
        if (r.location != NSNotFound) {
            
            NSRange r1 = [html rangeOfString:@"</FONT><FONT COLOR='#D8F7FF"];
            
            if (r1.location != NSNotFound) {
                
                if (r1.location > r.location) {
                    
                    NSString *title = [html substringWithRange:NSMakeRange(NSMaxRange(r), r1.location - NSMaxRange(r))];
                    title = [title stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    //NSString *deg = @" °F";
                    //title = [title stringByAppendingString:deg];
                    currentTemp = title;
                    
                }
            }
            
        }
    }
    return currentTemp;
    
}

-(int) returnCountError{
    return countError;
}

-(Boolean)isConnected {
    
    return connected;
}

@end
