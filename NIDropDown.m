//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, weak) UIView *parentView;
@property(nonatomic, strong) NSArray *list;

@property (assign, nonatomic) CGFloat height;

@end

@implementation NIDropDown

- (instancetype)initWithDropDownMenuFor:(UIView *)parent items:(NSArray *)items height:(CGFloat)height direction:(NSString *)direction {
    self = [super init];
    if (!self) return nil;
    
    CGRect btn = parent.frame;
    _height = height;
    _parentView = parent;
    _animationDirection = direction;
    _list = [NSArray arrayWithArray:items];

    if ([direction isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([direction isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 0;
    self.layer.shadowRadius = 0;
    self.layer.shadowOpacity = 0.1;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.layer.cornerRadius = 5;
    _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _table.separatorColor = [UIColor grayColor];
    
    [parent.superview addSubview:self];
    [self addSubview:_table];
    
    return self;
}

- (instancetype)initWithDropDownMenuFor:(UIView *)parent items:(NSArray *)items {
    self = [self initWithDropDownMenuFor:parent items:items height:(items.count * 40) direction:@"down"];
    if (!self) return nil;
    return self;
}

- (void)hideDropDownFrom:(UIView *)parent success:(void (^)(void))success
{
    self.isShowing = NO;
    CGRect btn = parent.frame;
    [UIView animateWithDuration:0.3 animations:^{
        if ([_animationDirection isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
        }else if ([_animationDirection isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        }
        _table.frame = CGRectMake(0, 0, btn.size.width, 0);
    }completion:^(BOOL finished){
        if (success) {
            success();
        }
    }];
}

#pragma mark - public method

- (void)show {
    self.isShowing = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([self.animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(self.parentView.frame.origin.x, self.parentView.frame.origin.y - self.height, self.parentView.frame.size.width, self.height);
    } else if([self.animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(self.parentView.frame.origin.x, self.parentView.frame.origin.y+self.parentView.frame.size.height, self.parentView.frame.size.width, self.height);
    }
    self.table.frame = CGRectMake(0, 0, self.parentView.frame.size.width, self.height);
    [UIView commitAnimations];
}

- (void)hide {
    self.isShowing = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    if ([_animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(self.parentView.frame.origin.x, self.parentView.frame.origin.y, self.parentView.frame.size.width, 0);
    }else if ([_animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(self.parentView.frame.origin.x, self.parentView.frame.origin.y+self.parentView.frame.size.height, self.parentView.frame.size.width, 0);
    }
    self.table.frame = CGRectMake(0, 0, self.parentView.frame.size.width, 0);
}

#pragma mark - tableview delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDownFrom:_parentView success:^{
        if (self.selectedItemBlock) {
            self.selectedItemBlock(indexPath.row);
        }
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

@end
