//
//  HHRunTimeRootViewController.m
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//

#import "HHRunTimeRootViewController.h"
#import "HHRunTimeTest.h"
#import "HHRunTimeManager.h"
#import "RunTimeTestCell.h"

@interface HHRunTimeRootViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>{
    
    NSArray *cellDatas;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HHRunTimeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    cellDatas = @[@"清空log",@"类名",@"属性列表",@"成员列表",@"类方法列表",@"实例方法列表",@"添加新方法",@"互换原始类方法",@"替换实例方法ONE",@"执行类方法",@"执行实例方法",@"关联属性",@"取消关联",@"消息转发"];
    
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


#pragma mark - func
//清空
- (void)zeroState{
    self.textView.text = @"";
    
}

//显示类名
- (void)showClassName{
    
    self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"类名:\n%@\n",[HHRunTimeManager returnClassName:[HHRunTimeTest class]]]];
}

//属性列表
- (void)showPropertyList{
    
    NSArray *propertyList = [HHRunTimeManager returnPropertyList:[HHRunTimeTest class]];
    NSMutableString *tem = [NSMutableString stringWithFormat:@"%@属性列表:\n",self.textView.text];
    for (NSString *propertyName in propertyList) {
        [tem appendString:[NSString stringWithFormat:@"%@\n",propertyName]];
    }
    self.textView.text = tem;
}

//成员列表
- (void)showIvarList{
    
    NSArray *ivarList = [HHRunTimeManager returnIvarList:[HHRunTimeTest class]];
    
    NSMutableString *tem = [NSMutableString stringWithFormat:@"%@成员列表:\n",self.textView.text];
    for (NSDictionary *ivar in ivarList) {
        [tem appendString:[NSString stringWithFormat:@"成员名:%@ 类型:%@\n",ivar[@"ivarName"],ivar[@"type"]]];
    }
    self.textView.text = tem;

}

//类方法列表
- (void)showClassMethodList{

    NSArray *classMethodList = [HHRunTimeManager returnClassList:[HHRunTimeTest class]];
    NSMutableString *tem = [NSMutableString stringWithFormat:@"%@类方法列表:\n",self.textView.text];
    for (NSString *methodName in classMethodList) {
        [tem appendString:[NSString stringWithFormat:@"%@\n",methodName]];
    }
    self.textView.text = tem;
}

//实例方法列表
- (void)showInstanceMethodList{
    
    NSArray *instanceMethodList = [HHRunTimeManager returnInstanceMethod:[HHRunTimeTest class]];
    NSMutableString *tem = [NSMutableString stringWithFormat:@"%@实例方法列表:\n",self.textView.text];
    for (NSString *methodName in instanceMethodList) {
        [tem appendString:[NSString stringWithFormat:@"%@\n",methodName]];
    }
    self.textView.text = tem;

}

//添加新实例方法
- (void)addMethod{
    
    [HHRunTimeManager addInstanceMethod:[HHRunTimeTest class] method:@selector(secondInstanceMethod) fromClass:[self class]];
    [self showInstanceMethodList];
}

//新的实例方法
- (NSString *)secondInstanceMethod{
    
    return @"运行时加入的实例方法";
}

//互换初始类方法
- (void)swapClassMethod{
    
    [HHRunTimeManager classMethodSwap:[HHRunTimeTest class] firstMethod:@selector(classMethodOne) secondMethod:@selector(classMethodTwo)];
    self.textView.text = [NSString stringWithFormat:@"%@已互换\n",self.textView.text];
}
//新建的实例方法，替换原始实例方法ONE
- (void)replaceInstanceOne{
    
    [HHRunTimeManager instanceMethodReplace:[HHRunTimeTest class] firstMethod:@selector(instanceMethodOne) secondMethod:@selector(secondInstanceMethod) fromClass:[self class]];
}

//执行类方法
- (void)runClassMethod{
    
    NSString *one = [HHRunTimeTest classMethodOne];
    NSString *two = [HHRunTimeTest classMethodTwo];
    self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"方法名:classMethodOne\n执行结果:%@\n方法名:classMethodTwo\n执行结果:%@\n",one,two]];
}

//执行实例方法
- (void)runInstanceMethod{
    
    HHRunTimeTest *test = [[HHRunTimeTest alloc]init];
    
    NSString *str = [test instanceMethodOne];
    self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"方法名:instanceMethodOne\n执行结果:%@\n",str]];
    
    
}

//关联属性
- (void)relationProperty{
    
    //关联属性，新建一个属性给视图控制器
    static char *key = "test";
    objc_setAssociatedObject(self, key, @"relationProperty", OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    NSString *str = objc_getAssociatedObject(self, key);
    
    self.textView.text = [NSString stringWithFormat:@"%@关联属性值:%@\n",self.textView.text,str];
   
    
}

//取消关联
- (void)removeProperty{
    
    //取消关联的属性
    objc_removeAssociatedObjects(self);
    
    NSArray *propertyList = [HHRunTimeManager returnPropertyList:[self class]];
    NSMutableString *tem = [NSMutableString stringWithFormat:@"%@属性列表:\n",self.textView.text];
    for (NSString *propertyName in propertyList) {
        [tem appendString:[NSString stringWithFormat:@"%@\n",propertyName]];
    }
    self.textView.text = tem;
}

//消息转发
- (void)messageForward{
    
    [self performSegueWithIdentifier:@"messageForward" sender:nil];
}

#pragma mark - UICollectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.item) {
        case 0:
            [self zeroState];
            break;
        case 1:
            [self showClassName];
            break;
        case 2:
            [self showPropertyList];
            break;
        case 3:
            [self showIvarList];
            break;
        case 4:
            [self showClassMethodList];
            break;
        case 5:
            [self showInstanceMethodList];
            break;
        case 6:
            [self addMethod];
            break;
        case 7:
            [self swapClassMethod];
            break;
        case 8:
            [self replaceInstanceOne];
            break;
        case 9:
            [self runClassMethod];
            break;
        case 10:
            [self runInstanceMethod];
            break;
        case 11:
            [self relationProperty];
            break;
        case 12:
            [self removeProperty];
            break;
        case 13:
            [self messageForward];
            break;
        default:
            break;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cellDatas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.view.frame.size.width-60)/3, 80);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    RunTimeTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RunTimeTestCell" forIndexPath:indexPath];
    cell.cellTitle.text = cellDatas[indexPath.item];
    return cell;
}


@end
