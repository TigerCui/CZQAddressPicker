# CZQAddressPicker
地址选择器,包括邮政编码,可设置初始选中
### 方法
```
/**
 *  初始化时选中
 *  pIndex  选中省的index
 *  cIndex  选中市的index
 *  dIndex  选中区的index
 */
- (void)selectedProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex districtIndex:(NSInteger)dIndex;
```
### 代理方法
```
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
```
### 如何使用
```
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
```