//
//  NIViewController.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface NIViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (strong, nonatomic) NIDropDown *dropDown;

- (IBAction)selectClicked:(id)sender;

@end
