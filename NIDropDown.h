//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^SelectedItemBlock)(NSInteger row);

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) SelectedItemBlock selectedItemBlock;

@property (nonatomic, copy) NSString *animationDirection;

@property (assign, nonatomic) BOOL isShowing;

- (void)hideDropDownFrom:(UIView *)parent success:(void (^)(void))success;
//- (instancetype)showDropDownFrom:(UIView *)parent height:(CGFloat)height items:(NSArray *)items direction:(NSString *)direction;
//- (instancetype)showDropDownMenuFor:(UIView *)parent items:(NSArray *)items;

- (instancetype)initWithDropDownMenuFor:(UIView *)parent items:(NSArray *)items;
- (instancetype)initWithDropDownMenuFor:(UIView *)parent items:(NSArray *)items height:(CGFloat)height direction:(NSString *)direction;

- (void)show;
- (void)hide;

@end
