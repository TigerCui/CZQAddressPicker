//
//  ViewController.m
//  CZQAddressPicker
//
//  Created by czq on 2018/1/19.
//  Copyright © 2018年 czq. All rights reserved.
//

#import "ViewController.h"
#import "CZQAddressPicker.h"

@interface ViewController ()<CZQAddressPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CZQAddressPicker *addressPicker = [[CZQAddressPicker alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, [UIScreen mainScreen].bounds.size.width, 216)];
    [self.view addSubview:addressPicker];
    addressPicker.delegate = self;
    [addressPicker selectedProvinceIndex:2 cityIndex:2 districtIndex:2];
}

- (void)addressPicker:(CZQAddressPicker *)addressPicker
  didSelectedProvince:(CZQProvince *)province
                 city:(CZQCity *)city
             district:(CZQDistrict *)district
               pIndex:(NSInteger)pIndex
               cIndex:(NSInteger)cIndex
               dIndex:(NSInteger)dIndex {
    NSLog(@"\n省:%@ index:%ld\n市:%@ index:%ld\n区:%@ index:%ld ",province.n, (long)pIndex, city.n, (long)cIndex, district.n, (long)dIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
