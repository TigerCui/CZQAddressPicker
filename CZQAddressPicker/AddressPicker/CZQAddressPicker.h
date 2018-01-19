//
//  CZQAddressPicker.h
//  CZQAddressPicker
//
//  Created by czq on 2018/1/19.
//  Copyright © 2018年 czq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZQAddressPicker;
#import "CZQProvince.h"//省
#import "CZQCity.h"//市
#import "CZQDistrict.h"//区

@protocol CZQAddressPickerDelegate<NSObject>
@optional
/**
 *  选择地址的回调
 *  addressPicker   address picker
 *  province        省
 *  city            市
 *  district        区
 *  pIndex          省那一列选中的row
 *  cIndex          市那一列选中的row
 *  dIndex          区那一列选中的row
 */
- (void)addressPicker:(CZQAddressPicker *)addressPicker
  didSelectedProvince:(CZQProvince *)province
                 city:(CZQCity *)city
             district:(CZQDistrict *)district
               pIndex:(NSInteger)pIndex
               cIndex:(NSInteger)cIndex
               dIndex:(NSInteger)dIndex;
@end

@interface CZQAddressPicker : UIView

@property (nonatomic, weak) id<CZQAddressPickerDelegate> delegate;

/**
 *  初始化时选中
 *  pIndex  选中省的index
 *  cIndex  选中市的index
 *  dIndex  选中区的index
 */
- (void)selectedProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex districtIndex:(NSInteger)dIndex;

@end
