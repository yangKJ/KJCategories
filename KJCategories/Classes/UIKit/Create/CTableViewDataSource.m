//
//  CTableViewDataSource.m
//  KJEmitterView
//
//  Created by yangkejun on 2019/4/25.
//  https://github.com/yangKJ/KJEmitterView
//  快捷链式创建UI

#import "CTableViewDataSource.h"

@interface CTableViewDataSource ()
@property (nonatomic, copy, readwrite) void(^xxblock)(UITableViewCell * cell, NSIndexPath * indexPath);
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, assign) CGFloat totalHeight;

@end
@implementation CTableViewDataSource

- (instancetype)initWithConfigureBlock:(void(^)(UITableViewCell * cell, NSIndexPath * indexPath))block{
    if (self = [super init]) {
        self.identifier = @"custom_table_identifier";
        self.xxblock = block;
        self.canEdit = NO;
        self.totalHeight = 0;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    self.totalHeight = 0;
    if (self.tableViewNumberSections) {
        return self.tableViewNumberSections();
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    @try {
        if (self.numberOfRowsInSection) {
            return self.numberOfRowsInSection(section);
        }
    } @catch (NSException *exception) {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.identifierAtIndexPath) {//设置标识符
        self.identifier = self.identifierAtIndexPath(indexPath);
    }
    UITableViewCell * tableViewCell = nil;
    @try {
        if (self.tableViewCellAtIndexPath) {
            tableViewCell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
            if (tableViewCell == nil) {
                tableViewCell = self.tableViewCellAtIndexPath(self.identifier, indexPath);
            }
        } else {
            tableViewCell = [tableView dequeueReusableCellWithIdentifier:self.identifier forIndexPath:indexPath];
        }
    } @catch (NSException *exception) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier];
    }
    //设置内容
    self.xxblock(tableViewCell, indexPath);
    
    return tableViewCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (self.deleteRowAtIndexPath) {
            self.deleteRowAtIndexPath(indexPath);
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.canEditRowAtIndexPath) {
        return self.canEditRowAtIndexPath(indexPath);
    }
    return self.canEdit;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.titleForHeaderInSection) {
        return self.titleForHeaderInSection(section);
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (self.titleForFooterInSection) {
        return self.titleForFooterInSection(section);
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0;
    if (self.heightForRowAtIndexPath) {
        rowHeight = self.heightForRowAtIndexPath(indexPath);
    } else {
        rowHeight = tableView.rowHeight;
    }
    self.totalHeight += rowHeight;
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;{
    if (self.heightForHeaderInSection) {
        return self.heightForHeaderInSection(section);
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.heightForFooterInSection) {
        return self.heightForFooterInSection(section);
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.viewForHeaderInSection) {
        return self.viewForHeaderInSection(section);
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.viewForFooterInSection) {
        return self.viewForFooterInSection(section);
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.allowsMultipleSelection == NO) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didDeselectRowAtIndexPath) {
        self.didDeselectRowAtIndexPath(indexPath);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editingStyleForRowAtIndexPath) {
        return self.editingStyleForRowAtIndexPath(indexPath);
    } else if (self.canEdit && tableView.allowsMultipleSelection) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.sectionIndexTitlesForTableView) {
        return self.sectionIndexTitlesForTableView();
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NSLocalizedString(@"删除", nil);
}

@end
