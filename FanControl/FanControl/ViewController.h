//
//  ViewController.h
//  FanControl
//
//  Created by David Paquette on 5/14/13.
//  Copyright (c) 2013 David Paquette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "arduinoFan.h"
#import "SettingView.h"

@interface ViewController : UIViewController
{
    arduinoFan *fan1;
    SettingView *view1;
    NSString *IPcheck;
    int countError;
    
}
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectedLabel;

- (IBAction)onButton:(UIButton *)sender;
- (IBAction)offButton:(UIButton *)sender;
- (IBAction)autoButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
-(void)updateTimer;
-(void)checkUserStatus;
-(NSString*)checkNewUser;
-(void)setOldUser;
@end
