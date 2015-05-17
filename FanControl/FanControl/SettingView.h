//
//  SettingView.h
//  FanControl
//
//  Created by David Paquette on 5/29/13.
//  Copyright (c) 2013 David Paquette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIViewController <UITextFieldDelegate>
{
    NSString *counterValue;
}
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
- (IBAction)refreshCounter:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UILabel *refreshLabel;
@property (weak, nonatomic) IBOutlet UIStepper *refreshValue;
- (IBAction)doneButton:(UIButton *)sender;

-(void)storeUpdateSettings;
-(NSString*)retrieveUpdateSettings;
-(void) updateViewObjects;
- (IBAction)safariLink:(UIButton *)sender;

-(void)storeIPSettings;
-(NSString*)retrieveIPSettings;
@end
