//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) void(^selectedItemBlock)(NSInteger row);

@property (nonatomic, copy) NSString *animationDirection;

- (void)hideDropDownFrom:(UIView *)parent success:(void (^)(void))success;
- (instancetype)showDropDownFrom:(UIView *)parent height:(CGFloat)height items:(NSArray *)items direction:(NSString *)direction;
- (instancetype)showDropDownMenuFor:(UIView *)parent items:(NSArray *)items;

@end
