//
//  SettingView.m
//  FanControl
//
//  Created by David Paquette on 5/29/13.
//  Copyright (c) 2013 David Paquette. All rights reserved.
//

#import "SettingView.h"
#import "arduinoFan.h"

@interface SettingView ()

@end

@implementation SettingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    double tempUpdateValue = [[self retrieveUpdateSettings] doubleValue];
    
    [_refreshValue setValue:tempUpdateValue];
    [self updateViewObjects];
    
   
    [_ipTextField setDelegate:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
    
}


- (IBAction)refreshCounter:(UIStepper *)sender {
    [self updateViewObjects];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self storeUpdateSettings ];
    [self storeIPSettings];
   
}

- (IBAction)doneButton:(UIButton *)sender {
    [self storeUpdateSettings ];
    [self storeIPSettings];
    
    
    
    NSString* filePathP = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileNameP = @"setErrorScreen.txt";
    NSString* fileAtPathP = [filePathP stringByAppendingPathComponent:fileNameP];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPathP]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPathP contents:nil attributes:nil];
    }
    
    
    [[@"0" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPathP atomically:NO];
    
    
}


-(void)storeUpdateSettings {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"refreshValue.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    
    [[counterValue dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
    
}

-(NSString*)retrieveUpdateSettings {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"refreshValue.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    
  
    NSString* content = [NSString stringWithContentsOfFile:fileAtPath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return content;
    
}

-(void)updateViewObjects {
    
        
        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* fileName = @"UserIPValue.txt";
        NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
            [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
        }
        
        
        NSString *test = @"";
        if([[self retrieveIPSettings] isEqual:test])
        {
            
        }
        else {
            _ipTextField.text = [self retrieveIPSettings];
        }

    
    
    int values = (int)[_refreshValue value];
    NSString *value = [NSString stringWithFormat:@"%d",values];
    _refreshLabel.Text = value;
    counterValue = value;
}

- (IBAction)safariLink:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://github.com/dpaquette01/Arduino-Fan-Control-Server"]];
}



-(void)storeIPSettings {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"UserIPValue.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    
    [[_ipTextField.text dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
    
}
-(NSString*)retrieveIPSettings{
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"UserIPValue.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    
    
    NSString* content = [NSString stringWithContentsOfFile:fileAtPath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return content;
}

-(void)dismissKeyboard {
    
    [_ipTextField resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[_ipTextField resignFirstResponder];
    
	return YES;
    
}

@end
