//
//  CZQAddressPicker.m
//  CZQAddressPicker
//
//  Created by czq on 2018/1/19.
//  Copyright © 2018年 czq. All rights reserved.
//

#import "CZQAddressPicker.h"
//数据
#import "CZQAPModel.h"//model
//工具
#import "MJExtension.h"

@interface CZQAddressPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>
//组件
@property (nonatomic, strong) UIPickerView *pickerView;
//数据
@property (nonatomic, strong) CZQAPModel *model;//数据模型
@end

@implementation CZQAddressPicker

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAddressData];//初始化数据源
        [self addObserver];//监听数据变化
        [self setupPickerView];
    }
    return self;
}

#pragma mark - picker view
- (void)setupPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_pickerView];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.pickerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component) {
        return self.model.provinces.count;
    }
    else if (1 == component){
        self.model.cities = self.model.provinces[_model.pIndex].c;
        return self.model.cities.count;
    }
    else if (2 == component){
        self.model.districts = self.model.cities[_model.cIndex].d;
        return self.model.districts.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (0 == component) {
        if (row > self.model.provinces.count - 1) {
            return nil;
        }
        return self.model.provinces[row].n;
    }
    else if (1 == component) {
        if (row > self.model.cities.count - 1) {
            return nil;
        }
        return self.model.cities[row].n;
    }
    else if (2 == component) {
        if (row > self.model.districts.count - 1) {
            return nil;
        }
        return self.model.districts[row].n;
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (0 == component) {
        _model.pIndex = row;
        _model.cIndex = 0;
        _model.dIndex = 0;
    }
    else if (1 == component){
        _model.cIndex = row;
        _model.dIndex = 0;
    } else {
        _model.dIndex = row;
    }
    if ([_delegate respondsToSelector:@selector(addressPicker:didSelectedProvince:city:district:pIndex:cIndex:dIndex:)]) {
        [_delegate addressPicker:self
             didSelectedProvince:_model.provinces[_model.pIndex]
                            city:_model.cities[_model.cIndex]
                        district:_model.districts[_model.dIndex]
                          pIndex:_model.pIndex
                          cIndex:_model.cIndex
                          dIndex:_model.dIndex];
    }
}

#pragma mark - 初始化数据
- (void)loadAddressData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSError  *error;
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return;
    }
    NSArray *address = [self serializationJsonString:jsonStr];
    NSMutableArray *provinces = [NSMutableArray new];
    for (NSDictionary *dict in address) {
        CZQProvince *province = [CZQProvince mj_objectWithKeyValues:dict];
        [provinces addObject:province];
    }
    self.model.provinces = [provinces copy];
}

#pragma mark - 逻辑
//解析json
- (id)serializationJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData  * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return result;
}

//监听
- (void)addObserver {
    [self.model addObserver:self forKeyPath:@"pIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self.model addObserver:self forKeyPath:@"cIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self.model addObserver:self forKeyPath:@"dIndex" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"pIndex"]) {
        NSInteger pIndex = [change[NSKeyValueChangeNewKey] integerValue];
        _model.cities = _model.provinces[pIndex].c;
        [_pickerView selectRow:pIndex inComponent:0 animated:NO];
        [_pickerView reloadComponent:1];
    }
    if ([keyPath isEqualToString:@"cIndex"]) {
        NSInteger cIndex = [change[NSKeyValueChangeNewKey] integerValue];
        _model.districts = _model.cities[cIndex].d;
        [_pickerView selectRow:cIndex inComponent:1 animated:NO];
        [_pickerView reloadComponent:2];
    }
    if ([keyPath isEqualToString:@"dIndex"]) {
        NSInteger dIndex = [change[NSKeyValueChangeNewKey] integerValue];
        [_pickerView selectRow:dIndex inComponent:2 animated:NO];
    }
}

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"pIndex"];
    [self.model removeObserver:self forKeyPath:@"cIndex"];
    [self.model removeObserver:self forKeyPath:@"dIndex"];
}

#pragma mark - 懒加载
- (CZQAPModel *)model {
    if (!_model) {
        _model = [[CZQAPModel alloc] init];
    }
    return _model;
}

#pragma mark - 接口
- (void)selectedProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex districtIndex:(NSInteger)dIndex {
    self.model.pIndex = pIndex;
    self.model.cIndex = cIndex;
    self.model.dIndex = dIndex;
}

@end
