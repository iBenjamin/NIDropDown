//
//  NIViewController.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIViewController ()
@property (strong, nonatomic) NIDropDown *dropDownMenu;
@end

@implementation NIViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3",nil];

    _btnSelect.layer.borderWidth = 1;
    _btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnSelect.layer.cornerRadius = 0;
    _dropDownMenu = [[NIDropDown alloc] initWithDropDownMenuFor:self.btnSelect items:arr];
    [_dropDownMenu setSelectedItemBlock:^(NSInteger row) {
        NSLog(@"%d", row);
    }];
}

- (void)viewDidUnload
{
    _btnSelect = nil;
    [self setBtnSelect:nil];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectClicked:(id)sender {
    if (self.dropDownMenu.isShowing) {
        [self.dropDownMenu hide];
    } else {
        [self.dropDownMenu show];
    }
//    NSArray * arr = [[NSArray alloc] init];
//    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3",nil];
//    if(_dropDown == nil) {
//        __weak __typeof(&*self)weakSelf = self;
////        _dropDown = [[NIDropDown alloc] showDropDownMenuFor:sender items:arr];
//        _dropDown = [[NIDropDown alloc] initWithDropDownMenuFor:sender items:arr];
//        [_dropDown show];
//        [_dropDown setSelectedItemBlock:^(NSInteger row){
//            NSLog(@"%ld", (long)row);
////            [weakSelf rel];
//        }];
//    }
//    else {
//        [_dropDown hideDropDownFrom:sender success:NULL];
////        [self rel];
//    }
}

-(void)rel{
    _dropDown = nil;
}

@end
