//
//  CZQAPModel.h
//  CZQAddressPicker
//
//  Created by czq on 2018/1/19.
//  Copyright © 2018年 czq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CZQProvince;
@class CZQCity;
@class CZQDistrict;

@interface CZQAPModel : NSObject

@property (nonatomic, strong) NSArray<CZQProvince *> *provinces;//省
@property (nonatomic, strong) NSArray<CZQCity *> *cities;//市
@property (nonatomic, strong) NSArray<CZQDistrict *> *districts;//区

@property (nonatomic, assign) NSInteger pIndex;//省index
@property (nonatomic, assign) NSInteger cIndex;//市index
@property (nonatomic, assign) NSInteger dIndex;//区index

@end
