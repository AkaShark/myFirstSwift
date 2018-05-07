//
//  GTagFlowView.m
//  GBigbang
//
//  Created by GIKI on 2017/10/13.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import "GTagFlowView.h"
#import "GTagFlowCell.h"
#import "GTagCollectionViewLayout.h"
#import "NSArray+GBigbang.h"
typedef NS_ENUM(NSUInteger, GRecognizerState) {
    GRecognizerStateNone,
    GRecognizerStateLeft,
    GRecognizerStateRight,
};

/**
 collection
 */
@interface GTagFlowView()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,GTagLayoutDataProtocol>

@property (nonatomic, strong) UIPanGestureRecognizer * panRecognizer;
@property (nonatomic, strong) NSMutableArray * indexPaths;
@property (nonatomic, strong) NSIndexPath * beginIndexPath;
@property (nonatomic, strong) NSIndexPath * lastIndexPath;
@property (nonatomic, assign) BOOL  beginSelectState;
@property (nonatomic, assign) GRecognizerState  recognizerState;
@property (nonatomic, assign) GRecognizerState  lastRecognizerState;

@property (nonatomic, strong) NSMutableArray * selectItems;
@end

@implementation GTagFlowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lineSpacing = 10;
        self.interitemSpacing = 4;
        self.supportSlideSelection = YES;
        self.edgeInsets =UIEdgeInsetsMake(0, 10, 0, 10);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[GTagFlowCell class] forCellWithReuseIdentifier:@"GTagFlowCell"];
        [self addSubview:self.collectionView];
        
        self.selectItems = [NSMutableArray array];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)configTagCollectionViewLayout
{
    GTagCollectionViewLayout *layout = [GTagCollectionViewLayout new];
    layout.delegate = self;
    [self configCustomLayout:layout];
}

- (void)configCustomLayout:(__kindof UICollectionViewLayout*)customLayout
{
    if (!customLayout) return;
    self.collectionView.collectionViewLayout = customLayout;
}

- (void)setSupportSlideSelection:(BOOL)supportSlideSelection
{
    _supportSlideSelection = supportSlideSelection;
    if (supportSlideSelection) {
        self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
        self.panRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:self.panRecognizer];
    }
}

- (void)setFlowDatas:(NSArray<GTagFlowItem *> *)flowDatas
{
    _flowDatas = flowDatas;
}

- (void)reloadDatas
{
    [self.collectionView reloadData];
}

- (void)performReload:(NSArray*)indexpaths {
    //刷新界面
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [UIView performWithoutAnimation:^{
        //刷新界面
        //        [self.collectionView reloadData];
        [self.collectionView performBatchUpdates:^{
            [self.collectionView reloadItemsAtIndexPaths:indexpaths];
        } completion:^(BOOL finished) {
        }];
    }];
    [CATransaction commit];
}

- (CGFloat)maxWidthOfLine_BookBangCollectionViewLayout
{
    return self.frame.size.width;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.flowDatas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GTagFlowCell *flowCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTagFlowCell" forIndexPath:indexPath];
    if (indexPath.item < self.flowDatas.count){
        GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:indexPath.item];
        [flowCell configFlowLayout:layout];
    }
    if (indexPath.item == self.flowDatas.count -1) {
        if (!CGSizeEqualToSize(self.bounds.size, self.collectionView.contentSize)) {
            if (self.heightChangedBlock) {
                self.heightChangedBlock(self.bounds.size.height, self.collectionView.contentSize.height);
            }
        }
    }
    return flowCell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.flowDatas.count){
        
        GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:indexPath.item];
        layout.isSelected = !layout.isSelected;
        
        [self addSelectLayout:layout];
        
        if (self.selectedChangedBlock) {
            self.selectedChangedBlock(self.selectItems.count>0);
        }
         [self performReload:@[indexPath]];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item >= self.flowDatas.count) return CGSizeZero;
    
    GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:indexPath.item];
    return layout.itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  self.edgeInsets ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.lineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.interitemSpacing;
}

#pragma mark - panRecognizer

- (void)panRecognizer:(UIPanGestureRecognizer*)recognizer
{
    CGPoint point = [recognizer locationInView:self.collectionView];
    
    if (recognizer.state == UIGestureRecognizerStateBegan ) { //UIGestureRecognizerStateEnded
        
        [self.indexPaths removeAllObjects];
        self.beginIndexPath = [self.collectionView indexPathForItemAtPoint:point];
        if (self.beginIndexPath.item >= self.flowDatas.count) return;
        if (!self.beginIndexPath) return;
        GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:self.beginIndexPath.item];
        self.beginSelectState = !layout.isSelected;
        if (![self.indexPaths containsObject:self.beginIndexPath]) {
            [self.indexPaths addObjectSafely:self.beginIndexPath];
            GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:self.beginIndexPath.item];
            layout.isSelected = self.beginSelectState;
            
            [self addSelectLayout:layout];
            
            [self performReload:@[self.beginIndexPath]];
            self.lastIndexPath = self.beginIndexPath;
            return;
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged ) {
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        
        if (!self.beginIndexPath) {
            self.beginIndexPath = indexPath;
            GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:self.beginIndexPath.item];
            self.beginSelectState = !layout.isSelected;
            if (![self.indexPaths containsObject:self.beginIndexPath]) {
                if (self.beginIndexPath.item >= self.flowDatas.count) return;
                if (!self.beginIndexPath) return;
                [self.indexPaths addObjectSafely:self.beginIndexPath];
                GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:self.beginIndexPath.item];
                layout.isSelected = self.beginSelectState;
                
                [self addSelectLayout:layout];
                
                [self performReload:@[self.beginIndexPath]];
                self.lastIndexPath = indexPath;
                return;
            }
        }
        
        if (indexPath.item >= self.flowDatas.count) return;
        if (!indexPath) return;
        if (self.lastIndexPath.item == indexPath.item) return;
        self.lastIndexPath = indexPath;
        
        if (self.beginIndexPath.item < indexPath.item) {
            self.recognizerState = GRecognizerStateRight;
        } else {
            self.recognizerState = GRecognizerStateLeft;
        }
        if (self.lastRecognizerState == GRecognizerStateNone) {
            self.lastRecognizerState = self.recognizerState;
        }
        if (self.lastRecognizerState != self.recognizerState) {
            self.lastRecognizerState = self.recognizerState;
            if (![self.indexPaths containsObject:self.beginIndexPath]) {
                [self.indexPaths addObjectSafely:self.beginIndexPath];
                GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:self.beginIndexPath.item];
                layout.isSelected = self.beginSelectState;
                
                [self addSelectLayout:layout];
                
            } else {
                GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:self.beginIndexPath.item];
                layout.isSelected = !layout.isSelected;
                
                [self addSelectLayout:layout];
            }
        }
        NSInteger count = labs(indexPath.item - self.beginIndexPath.item);
        if ( count > 1) {
            for (int index = 1; index <= count; index++) {
                NSIndexPath *path = nil;
                if (self.beginIndexPath.item < indexPath.item) {
                    path = [NSIndexPath indexPathForItem:self.beginIndexPath.item+index inSection:0];
                } else {
                    path = [NSIndexPath indexPathForItem:self.beginIndexPath.item-index inSection:0];
                }
                
                if (![self.indexPaths containsObject:path]) {
                    [self.indexPaths addObjectSafely:path];
                    GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:path.item];
                    layout.isSelected = self.beginSelectState;
                    
                    [self addSelectLayout:layout];
                    
                } else {
                    GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:path.item];
                    layout.isSelected = !layout.isSelected;
                    
                    [self addSelectLayout:layout];
                }
            }
        } else if(count == 1) {
            
            if (![self.indexPaths containsObject:indexPath]) {
                [self.indexPaths addObjectSafely:indexPath];
                GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:indexPath.item];
                layout.isSelected = self.beginSelectState;
                
                [self addSelectLayout:layout];
            } else {
                GTagFlowItem *layout = [self.flowDatas objectAtIndexSafely:indexPath.item];
                layout.isSelected =!layout.isSelected;
                
                [self addSelectLayout:layout];
            }
        }
        self.beginIndexPath = indexPath;
        NSArray *array = self.indexPaths.copy;
        
        [self performReload:array];
    } else if (recognizer.state == UIGestureRecognizerStateEnded|| recognizer.state == UIGestureRecognizerStateCancelled ) {
        if (self.selectedChangedBlock) {
            self.selectedChangedBlock(self.selectItems.count >0);
        }
        [self.indexPaths removeAllObjects];
        self.beginIndexPath = nil;
        self.recognizerState = 0;
        self.lastRecognizerState = 0;
    }
    
}

- (void)addSelectLayout:(GTagFlowItem*)layout
{
    if (layout.isSelected) {
        if (![self.selectItems containsObject:layout]) {
            [self.selectItems addObjectSafely:layout];
        }
    } else {
        if ([self.selectItems containsObject:layout]) {
            [self.selectItems removeObject:layout];
        }
    }
}

#pragma mark - getter Method

- (NSMutableArray *)indexPaths
{
    if (!_indexPaths) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

#pragma mark - public Method

- (NSArray *)filterAllSelectTitles
{
    __block NSMutableArray * array = [NSMutableArray array];
    NSArray * flowDatas = self.flowDatas.copy;
    [flowDatas enumerateObjectsUsingBlock:^(GTagFlowItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            [array addObjectSafely:obj.text];
        }
    }];
    return array.copy;
}

- (NSArray *)filterNoSelectTitles
{
    return [self filterAllSelectTitlesOrderByAdding:NO];
}

- (NSString*)getNewTextstring
{
    return [self getNewTextOrderByAdding:NO];
}

- (NSString*)getNewTextOrderByAdding:(BOOL)addingOrder
{
    __block NSString * string ;
    NSArray * array = self.flowDatas.copy;
    if (addingOrder) {
        array = self.selectItems.copy;
    }
    [array enumerateObjectsUsingBlock:^(GTagFlowItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
//            获取选择的文字
            self.selectArray = [NSMutableArray new];
            [self.selectArray addObject:obj.text];
            [self.backTheSelectedArray backTheSelectedTextArray:self.selectArray];
            string = [NSString stringWithFormat:@"%@%@",string?:@"",obj.text];
        }
    }];
    return string;
}

- (NSArray *)filterAllSelectTitlesOrderByAdding:(BOOL)addingOrder
{
    __block NSMutableArray * array = [NSMutableArray array];
    NSArray * flowDatas = self.flowDatas.copy;
    if (addingOrder) {
        flowDatas = self.selectItems.copy;
    }
    [flowDatas enumerateObjectsUsingBlock:^(GTagFlowItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.isSelected) {
            [array addObjectSafely:obj.text];
        }
    }];
    return array.copy;
}

- (void)hiddenAllVisibleCells
{
    NSArray * cells = [self.collectionView visibleCells];
    [cells makeObjectsPerformSelector:@selector(setAlpha:) withObject:@(0)];
}

- (void)showCellsWithAnimation
{
    NSArray * cells = [self.collectionView visibleCells];
    [cells enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int ran = [self getRandomNumber:1 too:4];
        [UIView animateWithDuration:ran animations:^{
            obj.alpha = 1;
        }];
    }];
}


-(int)getRandomNumber:(int)from too:(int)to
{
    return (from + arc4random()%(to + 1));
    
}
@end
