# StudyDemo
知识整理

## day1.关于应用生命周期和视图控制器的生命周期
    应用生命周期主要体现在appDelegate中的众多回调方法上，大体如下：
    1.将要加载完成:willFinishLaunching
    2.加载完成:didFinishLauching
    3.已经处于激活状态:didBecomeActive
    4.即将处于挂起暂停状态:willResignActive
    5.已经进入后台状态：didEnterBackground
    6.即将进入前台状态：willEnterForeground
    7.退出：willTerminate
  
    主要的生命周期包括上面这6种状态，
    1.当应用初次运行的时候，会依次调用方法1，2，3；
    2.当应用在前台时，接收到电话，短信，拉下通知栏时，调用方法4，使应用从激活状态转为暂停未激活状态；
    3.当用户取消接听电话，或者将通知栏拉上去时，调用方法3，使应用重新进入激活状态；
    4.当应用在前台，用户双击home键时，调用方法4，将应用由激活状态转为未激活状态
    5.当用户按下Home键将应用退到后台时,或用户锁屏时，调用方法4，5，将应用从激活状态，变为未激活状态，并由前台转到后台运行
    6.当用户再次切换到应用时，或用户开锁时(锁屏前应用在前台)，调用方法6，3，将应用转到前台，并处于激活状态
    7.当用户退出应用时，依次调用方法4，5，7

    视图控制器的生命周期，体现在视图控制器自带的几个相关方法上，大体如下：
    1.loadView 加载视图
    2.viewDidLoad 视图已经加载
    3.viewWillAppear 视图控制器即将展示
    4.viewDidAppear 视图控制器已经展示
    5.viewWillDisappear 视图控制器即将不显示
    6.viewDidDisappear 视图控制器已经不显示
  
    当AB两个视图控制器进行切换时，例如已显示A视图，再展示B视图，则依次为A视图控制器将要消失，B视图控制器将要出现(如果是初次加载，需要有加载过程)，A视图控制器已经消失，B视图控制器已经出现。
    
    
## day2.runtime && 消息转发

### runtime

    runtime里可以看到对于class的定义，每个class里包含一个isa指针，指向类对象；同时还包含父类名，本类名，成员变量列表，方法列表，方法缓存，协议列表 等信息。以便于在运行时，进行相关信息的查找，匹配。
 
    struct objc_class {
    Class isa  OBJC_ISA_AVAILABILITY;
 
    #if !__OBJC2__
    Class super_class                                        OBJC2_UNAVAILABLE;
    const char *name                                         OBJC2_UNAVAILABLE;
    long version                                             OBJC2_UNAVAILABLE;
    long info                                                OBJC2_UNAVAILABLE;
    long instance_size                                       OBJC2_UNAVAILABLE;
    struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
    struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
     #endif
 
    } OBJC2_UNAVAILABLE;
    
    相应方法(部分)<br>
    获取类名：object_getClassName(id obj);<br>
    获取成员列表：class_copyIvarList(Class cls,unsigned int *outCount);<br>
    获取方法列表：class_copyMethodList(Class cls,unsigned int *outCount);类方法时，第一个参数需要传入object_getClass(cls)<br>
    获取属性列表：class_copyPropertyList(Class cls,unsigned int *outCount);<br>
    获取协议列表：class_copyProtocolList(Class cls,unsigned int *outCount);<br>
    添加方法：class_addMethod(Class cls, SEL name, IMP imp,const char *types);<br>
    方法互换：method_exchangeImplementations(Method m1, Method m2);<br>
    方法替换：class_replaceMethod(Class cls, SEL name, IMP imp,const char *types);<br>
    关联属性：objc_setAssociatedObject(id object, const void *key);<br>
    取消关联：objc_removeAssociatedObjects(id object);<br>
    获得关联的属性：objc_getAssociatedObject(id object, const void *key);<br>
    具体可以在使用过程中，动态对类或实体进行增加方法，关联属性，方法替换，互换等操作。<br>
    
### 消息转发
    
    oc里当调用方法发送消息时，会调用objc_msgSend方法，它会现在objc的方法缓存中查找方法，如果没有就在方法列表中查找，
    如果没有就向父类中查找，如果找到了就执行相应IMP，如果到最后都没有找到的话，就意味着没有对应的方法可提供响应，
    这时候就会进入到动态决议和消息转发阶段，依次会经过三个判断，来进行补救(1，2，3),如果还是无果，则会进入4，程序会直接崩溃
    
    1.+ (BOOL)resolveInstanceMethod:(SEL)sel 实例方法
    + (BOOL)resolveClassMethod:(SEL)sel 类方法
    可以动态添加方法来解决，如果返回NO 将进入下一步
    2.- (id)forwardingTargetForSelector:(SEL)aSelector 将消息转发给其他对象，如果返回的是self或nil 将会进入下一步
    3.- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
    进行方法签名获取，如果签名不为空，则调取下面的方法，进行转发(可转发给多个对象)，如果为空，则调取4
    - (void)forwardInvocation:(NSInvocation *)anInvocation
    4.- (void)doesNotRecognizeSelector:(SEL)aSelector
    
## day3 事件分发和响应者链
  
    当用户点击了屏幕上的视图，应用是如何做出响应的呢？这里主要通过事件分发和响应者链来达到目的。<br>
    1.用户点击视图后，发生了触摸事件，系统会将这个事件放到事件队列中，当排到它的时候，就会对其进行事件分发，找到接受这个事件的视图。<br>
    事件的分发是由父视图向子视图传递，及从UIApplication开始到UIWindw到UIView再到各个子视图；<br>
    
    如何查找的呢：调用hitTest:WithEvent:方法<br>
    I，首先判断自己是否能接收事件，如果能就继续判断，不能，就停止该视图及其子视图的事件分发；<br>
    II，调用pointInside:withEvent: 返回触摸点是否在视图内，如果是，再递归检查该视图的子视图(从最上面的子视图开始)，直到找到最初的应该响应事件的视图，到此事件分发完毕,不是，该视图及其子视图线路结束；<br>
    The implementation of hitTest:withEvent: in UIResponder does the following:<br>
    It calls pointInside:withEvent: of self<br>
    If the return is NO, hitTest:withEvent: returns nil. the end of the story.<br>
    If the return is YES, it sends hitTest:withEvent: messages to its subviews. it starts from the top-level subview, and<br> continues to other views until a subview returns a non-nil object, or all subviews receive the message.<br>
    If a subview returns a non-nil object in the first time, the first hitTest:withEvent: returns that object. the end of the story.<br>
    If no subview returns a non-nil object, the first hitTest:withEvent: returns self
     当找到了这个视图后，开始事件的响应，从最初始的响应者开始，调用<br>
     touchBegin:WithEvent:  touchMove:WithEvent: touchEnd:WithEvent:,依次进行响应，响应不了就传给下一个响应者，知道UIApplication 如果也响应不了，则会丢弃该事件<br>
     通过重载hitTest:WithEvent:方法，可以扩大视图的点击事件相应范围<br>
    
