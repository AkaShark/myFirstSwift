//
//  HWPublishBaseController.m
//  PhotoSelector
//
//  Created by 洪雯 on 2017/1/12.
//  Copyright © 2017年 洪雯. All rights reserved.
//

#import "HWPublishBaseController.h"
#import "GCQiniuUploadManager.h"
#import <BmobSDK/Bmob.h>
@interface HWPublishBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource,JJPhotoDelegate,HWImagePickerSheetDelegate>{
    NSString *pushImageName;
    //添加图片提示
    UILabel *addImageStrLabel;
}

@property (nonatomic, strong) HWImagePickerSheet *imgPickerActionSheet;

@property (nonatomic,strong) NSString *patlentHospital;
@property (nonatomic,strong) NSString *medicinaType;

@end

@implementation HWPublishBaseController

static NSString * const reuseIdentifier = @"HWCollectionViewCell";

-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_showActionSheetViewController) {
            _showActionSheetViewController = self;
        }
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"返回-2"] forState:0];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/** 初始化collectionView */
-(void)initPickerView{
    _showActionSheetViewController = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.pickerCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    if (_showInView) {
        [_showInView addSubview:self.pickerCollectionView];
    }else{
        [self.view addSubview:self.pickerCollectionView];
    }
    
    self.pickerCollectionView.delegate=self;
    self.pickerCollectionView.dataSource=self;
    self.pickerCollectionView.backgroundColor = [UIColor whiteColor];
    
    if(_imageArray.count == 0)
    {
        _imageArray = [NSMutableArray array];
    }
    if(_bigImageArray.count == 0)
    {
        _bigImageArray = [NSMutableArray array];
    }
    pushImageName = @"plus.png";
    
    _pickerCollectionView.scrollEnabled = NO;

    //上传图片提示
    addImageStrLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 70, 20)];
    addImageStrLabel.text = @"上传图片";
    addImageStrLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    [self.pickerCollectionView addSubview:addImageStrLabel];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"HWCollectionViewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"HWCollectionViewCell"];
    // Set up the reuse identifier
    HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"HWCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == _imageArray.count) {
        [cell.profilePhoto setImage:[UIImage imageNamed:pushImageName]];
        cell.closeButton.hidden = YES;
        
        //没有任何图片
        if (_imageArray.count == 0) {
            addImageStrLabel.hidden = NO;
        }
        else{
            addImageStrLabel.hidden = YES;
        }
    }
    else{
        [cell.profilePhoto setImage:_imageArray[indexPath.item]];
        cell.closeButton.hidden = NO;
    }
    [cell setBigImageViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto .userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [self changeCollectionViewHeight];
    return cell;
}
#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-64) /4 ,([UIScreen mainScreen].bounds.size.width-64) /4);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 8, 20, 8);
}

#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_imageArray.count)) {
        [self.view endEditing:YES];
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        HWCollectionViewCell *cell = (HWCollectionViewCell*)[_pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImageView || !cell.BigImageView.image) {
            
            [cell setBigImageViewWithImage:[self getBigIamgeWithALAsset:_arrSelected[index]]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImageView] selecImageindex:0];
    }
}
- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [_bigImgDataArray addObject:imageData];

    return [UIImage imageWithData:imageData];
}
#pragma mark - 选择图片
- (void)addNewImg{
    if (!_imgPickerActionSheet) {
        _imgPickerActionSheet = [[HWImagePickerSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
    if (_arrSelected) {
        _imgPickerActionSheet.arrSelected = _arrSelected;
    }
    _imgPickerActionSheet.maxCount = _maxCount;
    [_imgPickerActionSheet showImgPickerActionSheetInView:_showActionSheetViewController];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    
    
    [self.pickerCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
    
    for (NSInteger item = sender.tag; item <= _imageArray.count; item++) {
        HWCollectionViewCell *cell = (HWCollectionViewCell*)[self.pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.closeButton.tag--;
        cell.profilePhoto.tag--;
    }
    
    [self changeCollectionViewHeight];
}

#pragma mark - 改变view，collectionView高度
- (void)changeCollectionViewHeight{
    
    if (_collectionFrameY) {
        _pickerCollectionView.frame = CGRectMake(0, _collectionFrameY, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
    }
    else{
        _pickerCollectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
    }
    [self pickerViewFrameChanged];
    
}
/**
 *  相册完成选择得到图片
 */
-(void)getSelectImageWithALAssetArray:(NSArray *)ALAssetArray thumbnailImageArray:(NSArray *)thumbnailImgArray{
    //（ALAsset）类型 Array
    _arrSelected = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    _imageArray = [NSMutableArray arrayWithArray:thumbnailImgArray] ;
    
    [self.pickerCollectionView reloadData];
}
- (void)pickerViewFrameChanged{
    
}
- (void)updatePickerViewFrameY:(CGFloat)Y{
    
    _collectionFrameY = Y;
    _pickerCollectionView.frame = CGRectMake(0, Y, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
}

#pragma mark - 防止奔溃处理
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
//获得大图
- (NSArray*)getBigImageArrayWithALAssetArray:(NSArray*)ALAssetArray{
    _bigImgDataArray = [NSMutableArray array];
    NSMutableArray *bigImgArr = [NSMutableArray array];
    for (ALAsset *set in ALAssetArray) {
        [bigImgArr addObject:[self getBigIamgeWithALAsset:set]];
    }
    _bigImageArray = bigImgArr;
    return _bigImageArray;
}
#pragma mark - 获得选中图片各个尺寸
- (NSArray*)getALAssetArray{
    return _arrSelected;
}

- (NSArray*)getBigImageArray{
    
    return [self getBigImageArrayWithALAssetArray:_arrSelected];
}

- (NSArray*)getSmallImageArray{
    return _imageArray;
}

- (CGRect)getPickerViewFrame{
    return self.pickerCollectionView.frame;
}



- (void)hidesTabBar:(BOOL)hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for (UIView *view in self.tabBarController.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width , view.frame.size.height)];
                
            }else{
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height - 49, view.frame.size.width, view.frame.size.height)];
                
            }
        }else{
            if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
                if (hidden) {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
                    
                }else{
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 49 )];
                    
                }
            }
        }
    }
    [UIView commitAnimations];
    
}

-(void)back
{
    
    [self getBigImageArray];
    NSLog(@"%@",_bigImgDataArray);
    if (self.bigImgDataArray.count != 0)
    {
        
        if (self.bigImgDataArray.count == 1)
        {
            
            [[GCQiniuUploadManager sharedInstance] createToken];
            [[GCQiniuUploadManager sharedInstance]uploadData:self.bigImgDataArray[0] key:[NSString stringWithFormat:@"%@",self.objectID] progress:^(float percent) {
                
            } completion:^(NSError *error, NSString *link, NSInteger index) {
                [self upOneBmobData];
                NSLog(@"%@",link);
            }];
        }
        else
        {
            _nameArray = [NSMutableArray new];
            for (int i=0; i<self.bigImgDataArray.count; i++)
            {
                NSString *name = [NSString stringWithFormat:@"%@%d",self.objectID,i];
                [_nameArray addObject:name];
            }
            
            [[GCQiniuUploadManager sharedInstance] createToken];
            [[GCQiniuUploadManager sharedInstance] uploadDatas:self.bigImgDataArray key:self.nameArray progress:^(float percent) {
                
            } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
                NSLog(@"%@",link);
            } allTasksCompletion:^{
                [self upBmobDatas];
            }];
        }
       
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//单张图片的时候
-(void)upOneBmobData
{
    
    BmobObject *changeData = [BmobObject objectWithoutDataWithClassName:@"medicinalRecord" objectId:self.objectID];
    [changeData setObject:[NSString stringWithFormat:@"%@%@",qiNiuStr,self.objectID] forKey:@"inspectionPictureURL"];
    
    [changeData updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful)
        {
            NSLog(@"添加成功");
        }
        else
        {
            NSLog(@"添加失败");
        }
    }];
}

//多张图片
-(void)upBmobDatas
{
    BmobObject *changeData = [BmobObject objectWithoutDataWithClassName:@"medicinalRecord" objectId:self.objectID];
    
    [changeData setObject:[self reduceTheString:self.nameArray] forKey:@"inspectionPictureURL"];
    
    [changeData updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful)
        {
            NSLog(@"添加多张图片成功");
        }
        else
        {
            NSLog(@"添加多张图片失败");
        }
    }];
}

-(NSString *)reduceTheString:(NSMutableArray *)array
{
    NSMutableString *bmobString = [NSMutableString new];
    for (int i=0; i<self.nameArray.count; i++)
    {
        [bmobString appendString:qiNiuStr];
        [bmobString appendString:self.nameArray[i]];
        if (i == self.nameArray.count-1)
        {
            
        }
        else
        {
            [bmobString appendString:@","];
        }
        
    }
    return (NSString *) bmobString;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
