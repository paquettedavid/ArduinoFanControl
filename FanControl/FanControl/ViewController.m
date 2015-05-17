//
//  ViewController.m
//  FanControl
//
//  Created by David Paquette on 5/14/13.
//  Copyright (c) 2013 David Paquette. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController

NSTimer *timerNoOne;




- (void) updateTimerNoTwo:(NSTimer *) timer {
	
    [self updateTexts];
    
}


-(void)updateTexts{
    [fan1 updateReadings];
    [fan1 testConnection];
    if([fan1 isConnected]) {
        //_connectedLabel.textColor = [UIColor whiteColor];
        _connectedLabel.text = @"connected";
    _statusLabel.text = [fan1 getStatus];
   // NSString *testVar = [fan1 getStatus];
    _tempLabel.text = [fan1 getTemp];
    _minTempLabel.text = [fan1 minTemp];
    _maxTempLabel.text = [fan1 maxTemp];
    }
    else{
        
        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* fileName = @"setErrorScreen.txt";
        NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
            [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
        }
        
        
        
        NSString* content = [NSString stringWithContentsOfFile:fileAtPath
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
        NSString *testVar = @"0";
        if([content isEqual:testVar])
        {
        UIAlertView* alert;
        alert = [[UIAlertView alloc] initWithTitle:@"I'm Sorry" message:@"There was an error while trying to connect to your device. Please check your configuration and re-enter your IP address. Also, make sure you have a good connection to your network." delegate:nil cancelButtonTitle:@"Okay!" otherButtonTitles: nil];
        [alert show];
               [self setError];
        
       // _connectedLabel.textColor = [UIColor blackColor];
        }
        [timerNoOne invalidate];
        timerNoOne = nil;
        _connectedLabel.text = @"not connected";
    }

    }






- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    view1 = [SettingView new];
    
    [self checkUserStatus];
    
    
}


-(void)viewDidDisappear:(BOOL)animated {
    [timerNoOne invalidate];
    timerNoOne = nil;
    
    [self setError];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)offButton:(UIButton *)sender {
    
    if([fan1 isConnected]){
        [fan1 fanOFF];
    [self updateTexts];
    }
    
}

- (IBAction)autoButton:(UIButton *)sender {
    if([fan1 isConnected]){
        [fan1 fanAUTO];
        [self updateTexts];
    }
}
- (IBAction)onButton:(UIButton *)sender {
    if([fan1 isConnected]){
        [fan1 fanON];
        [self updateTexts];
    }
}



-(void)updateTimer {
    
    double tempUpdateValue = [[view1 retrieveUpdateSettings] doubleValue];
    
    timerNoOne = [NSTimer scheduledTimerWithTimeInterval:tempUpdateValue
                                                  target:self
                                                selector:@selector(updateTimerNoTwo:)
                                                userInfo:nil
                                                 repeats:YES];
    
}

-(void)checkUserStatus{
    
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"UserIPValue.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    NSString *test = @"";
    
    if([[self checkNewUser] isEqual:test]) {
        UIAlertView* alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"Welcome to the Arduino Fan Control app! Please tap on the little 'i' in the bottom right hand corner to enter your fans IP address." delegate:nil cancelButtonTitle:@"Okay!" otherButtonTitles: nil];
        [alert show];
     
    }
    
    if([[view1 retrieveIPSettings] isEqual:test])
    {
       
     
    }
    else {
        
            fan1 = [arduinoFan new];
            
            [fan1 SetIPAddress:[view1 retrieveIPSettings]];
            [self updateTexts];
        [self updateTimer];
            
       
    }
    
[self setOldUser];
    
    
    
    
}

-(void)setOldUser {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"newUser.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    
    [[@"1" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
    
}

-(NSString*)checkNewUser {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"newUser.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }

    
    
    NSString* content = [NSString stringWithContentsOfFile:fileAtPath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return content;

}

-(void) setError{
    
    NSString* filePathP = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileNameP = @"setErrorScreen.txt";
    NSString* fileAtPathP = [filePathP stringByAppendingPathComponent:fileNameP];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPathP]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPathP contents:nil attributes:nil];
    }
    
    
    [[@"1" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPathP atomically:NO];
}
@end
