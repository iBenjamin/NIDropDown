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
@property(nonatomic, strong) UIView *sender;
@property(nonatomic, strong) NSArray *list;

@end

@implementation NIDropDown

- (instancetype)showDropDownMenuFor:(UIView *)parent items:(NSArray *)items
{
    return [self showDropDownFrom:parent height:(items.count * 40) items:items direction:@"down"];
}

- (instancetype)showDropDownFrom:(UIView *)parent height:(CGFloat)height items:(NSArray *)items direction:(NSString *)direction
{
    _sender = parent;
    _animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect btn = parent.frame;
        self.list = [NSArray arrayWithArray:items];
        
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
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y - height, btn.size.width, height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, height);
        }
        _table.frame = CGRectMake(0, 0, btn.size.width, height);
        [UIView commitAnimations];
        [parent.superview addSubview:self];
        [self addSubview:_table];
    }
    return self;
}

- (void)hideDropDownFrom:(UIView *)parent success:(void (^)(void))success
{
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
    cell.textLabel.text =[_list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDownFrom:_sender success:^{
        if (_selectedItemBlock) {
            _selectedItemBlock(indexPath.row);
        }
    }];
    
}

@end
