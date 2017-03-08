//
//  HHMessageForwardViewController.m
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//
//
//  oc里当调用方法发送消息时，会调用objc_msgSend方法，它会现在objc的方法缓存中查找方法，如果没有就在方法列表中查找，如果没有就向父类中查找，如果找到了就执行相应IMP，如果到最后都没有找到的话，就意味着没有对应的方法可提供响应，这时候就会进入到动态决议和消息转发阶段，依次会经过三个判断，来进行补救(1，2，3),如果还是无果，则会进入4，程序会直接崩溃
//
//  1.+ (BOOL)resolveInstanceMethod:(SEL)sel 实例方法
//    + (BOOL)resolveClassMethod:(SEL)sel 类方法
//    可以动态添加方法来解决，如果返回NO 将进入下一步2
//  2.- (id)forwardingTargetForSelector:(SEL)aSelector 将消息转发给其他对象，如果返回的是self或nil 将会进入下一步3
//  3.- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//  进行方法签名获取，如果不为空，则调取下面的方法，进行转发(可转发给多个对象)，如果为空，则调取4
//    - (void)forwardInvocation:(NSInvocation *)anInvocation
//  4.- (void)doesNotRecognizeSelector:(SEL)aSelector
//
//
//

#import "HHMessageForwardViewController.h"
#import "forwardTest.h"
#import "subForwardTest.h"
@interface HHMessageForwardViewController (){
    
    forwardTest *forward;
    subForwardTest *subForward;
}
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation HHMessageForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    forward = [[forwardTest alloc]init];
    subForward = [[forwardTest alloc]init];
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

#pragma mark - action
- (IBAction)clickButton:(UIButton *)sender {
    
    switch (sender.tag - 100) {
        case 0:
            [self normalMethod];
            break;
        case 1:
            self.showLabel.text = [subForward noMethod];
            break;
        case 2:
            self.showLabel.text = [subForward noMethodToo];
            break;
        case 3:
            self.showLabel.text = [subForward noMethodAgain];
            break;
        case 4:
            self.showLabel.text = @"淘气！！！";
            break;
            
        default:
            break;
    }
}


#pragma mark - func
- (void)normalMethod{
    self.showLabel.text = @"正常发起成功";
}




@end
