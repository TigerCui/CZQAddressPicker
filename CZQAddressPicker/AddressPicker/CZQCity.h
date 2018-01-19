//
//  CZQCity.h
//  CZQAddressPicker
//
//  Created by czq on 2018/1/19.
//  Copyright © 2018年 czq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CZQDistrict;

@interface CZQCity : NSObject

@property (nonatomic, strong) NSString *ID;//邮政编码
@property (nonatomic, strong) NSString *n;//名称
@property (nonatomic, copy) NSArray<CZQDistrict *> *d;//区

@end
