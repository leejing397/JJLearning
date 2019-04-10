//
//  ViewController.m
//  KVCTest
//
//  Created by Iris on 2019/4/9.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

#import "BankAccount.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (nonatomic, strong) NSMutableArray *arrayM1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.1 普通用法——访问对象属性
    /*
     - (nullable id)valueForKey:(NSString *)key;
     - (void)setValue:(nullable id)value forKey:(NSString *)key;
     */
    BankAccount *myAccount = [[BankAccount alloc]init];
    myAccount.currentBalance = @100;
    
    [myAccount setValue:@300 forKey:@"currentBalance"];
    
    NSString *currentBalanceStr = [myAccount valueForKey:@"currentBalance"];
    NSLog(@"currentBalanceStr====%@",currentBalanceStr);
    
    //1.2 普通用法——按键路径访问属性
    /*
     - (nullable id)valueForKeyPath:(NSString *)keyPath;
     - (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;
     */
    //使用点语法
    NSString *myName = myAccount.owner.name;
    Person *person = [[Person alloc]init];
    person.name = @"小明";
    person.age = 15;
    myAccount.owner = person;
    myName = myAccount.owner.name;
    NSLog(@"myName====%@",myName);
    [myAccount setValue:@"小红" forKeyPath:@"owner.name"];
    myName = [myAccount valueForKeyPath:@"owner.name"];
    NSLog(@"myName====%@",myName);
    
    //1.3 普通用法——键未定义异常
    /*
     错误信息：
     Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Person 0x604000237a80> valueForUndefinedKey:]: this class is not key value coding-compliant for the key sex.'
     */
    /*
     根据KVC规定的方式（搜索模式）找不到由key命名的属性时，就会调用获取值的valueForUndefinedKey:或设置值的setValue:forUndefinedKey:方法，系统默认的该方法会引发一个 NSUndefinedKeyException的异常导致崩溃，我们可以重写该方法避免崩溃。并且我们也可以在重写该方法时，加入逻辑处理以使其更加的优雅。
     */
    /*
     // 重写UndefinedKey:方法
     // getter
     - (id)valueForUndefinedKey:(NSString *)key {
     if ([key isEqualToString:@"sex"]) {
     return @"人妖";
     }
     return nil;
     }
     // setter
     - (void)setValue:(id)value forUndefinedKey:(NSString *)key {
     
     }
     */
    NSString *sexStr = [myAccount valueForKeyPath:@"owner.sex"];
    NSLog(@"异常====%@",sexStr);
    /*
     重写UndefinedKey:方法之后
     打印:异常====人妖
     */
    
    //1.4 普通用法——非对象值和nil
    [myAccount setValue:nil forKey:@"currentBalance"];
    NSLog(@"currentBalance====%@",currentBalanceStr);
    /*
     上面打印：
     currentBalance====300
     */
    [myAccount setNilValueForKey:@"currentBalance"];
    /*
     调用崩溃
     */
    NSLog(@"currentBalance====%@",currentBalanceStr);
   /*
    重写 setNilValueForKey:方法
    - (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"currentBalance"]) {
    [self setValue:@(0) forKey:@"currentBalance"];
    } else {
    [super setNilValueForKey:key];
    }
    }
    */
    
    //1.5 普通用法——多值访问
    NSDictionary *dict = [person dictionaryWithValuesForKeys:@[@"name",@"age"]];
    NSLog(@"多值==%@",dict);
    /* 上面打印：
     多值=={
     age = 15;
     name = "\U5c0f\U7ea2";
     }
     */
    dict = @{@"name":@"sepCode",@"age":@(62)};
    [person setValuesForKeysWithDictionary:dict];
    dict = [person dictionaryWithValuesForKeys:@[@"name",@"age"]];
    NSLog(@"修改后多值==%@",dict);
    /*上面打印:
     修改后多值=={
     age = 62;
     name = sepCode;
     }
     */
    
    //2.1特殊用法——访问集合属性
    Transaction *transaction1 = [[Transaction alloc]init];
    transaction1.payee = @"Google";
    transaction1.amount = @2018;
    transaction1.date = [NSDate date];
    
    Transaction *transaction2 = [[Transaction alloc]init];
    transaction2.payee = @"hebe";
    transaction2.amount = @2019;
    transaction2.date = [NSDate date];
    
    myAccount.transactions = @[transaction1,transaction2];
    NSArray *payees = [myAccount valueForKeyPath:@"transactions.payee"];
    NSLog(@"payees==%@",payees);
    /*上面打印：
     payees==(
     Google,
     hebe
     )
     */
    /*
     请求transactions.payee键路径的值将返回一个数组，包含transactions中所有的payee对象。这也适用于键路径中的多个数组。假如我们想获取多个银行账户中的所有收款人，请求键路径accounts.transactions.payee的值返回一个数组，其中包含所有帐户中所有交易的所有收款人对象。
     */
    /*
     对于获取值我们看到了KVC的方便之处，但是对于设置值我们却很少用到KVC。它会把集合内包含的所有键对象的值设置为相同的值，这不是我们想要的结果。
     */
    [myAccount setValue:@"Jimmy" forKeyPath:@"transactions.payee"];
    payees = [myAccount valueForKeyPath:@"transactions.payee"];
    NSLog(@"修改后的payees==%@",payees);
    /*
     修改后的payees==(
     Jimmy,
     Jimmy
     )
     */
    //以NSMutableArry为例子--mutableArrayValueForKey:
    self.arrayM = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSLog(@"arry.count: %ld, arry:%p", self.arrayM.count, self.arrayM);
    [self addObserver:self forKeyPath:@"arrayM" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    //2.2特殊用法——使用结合运算符——①聚合运算符
    NSNumber *transactionAverage = [myAccount.transactions  valueForKeyPath:@"@avg.amount"];
    NSNumber *numberOfTransactions = [myAccount.transactions  valueForKeyPath:@"@count"];
    NSNumber *latest = [myAccount.transactions  valueForKeyPath:@"@max.amount"];
    NSNumber *earliest = [myAccount.transactions valueForKeyPath:@"@min.amount"];
    NSNumber *amountSum = [myAccount.transactions valueForKeyPath:@"@sum.amount"];
    NSLog(@"聚合运算符--平均数=%@,总数=%@,最大=%@,最小=%@,总共=%@",transactionAverage,numberOfTransactions,latest,earliest,amountSum);
    
    /*打印结果：
     聚合运算符--平均数=2018.5,总数=2,最大=2019,最小=2018,总共=4037
     */
    
    //2.2特殊用法——使用结合运算符——②数组运算符(https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/CollectionOperators.html#//apple_ref/doc/uid/20002176-SW7)
    //@distinctUnionOfObjects:获取数组中每个对象的属性的值,放到一个数组中并返回,会对数组去重.所以,通常这个对象操作符可以用来对数组元素的去重,快捷高效;
    //The @distinctUnionOfArrays operator is similar, but removes duplicate objects.

    NSArray *distinctPayees = [myAccount.transactions valueForKeyPath:@"@distinctUnionOfObjects.payee"];
    NSLog(@"distinctPayees=%@",distinctPayees);

    //@unionOfObjects: 获取数组中每个对象的属性的值,放到一个数组中并返回,但不会去重;
    //The @unionOfObjects operator provides similar behavior, but without removing duplicate objects.
    NSArray *unionPayees = [myAccount.transactions valueForKeyPath:@"@unionOfObjects.payee"];
    NSLog(@"unionPayees=%@",unionPayees);
    
    //2.2特殊用法——使用结合运算符——③嵌套运算符
    //array- @distinctUnionOfArrays 返回操作对象(数组)中的所有元素,即返回这个数组本身.会去重.
    //array- @unionOfArrays 首先获取操作对象(数组)中的所有元素,然后装到一个新的数组中并返回,不会对这个数组去重.
    
    //set- @distinctUnionOfSets返回操作对象（且操作对象内对象必须是数组/集合）中数组/集合的所有对象，返回值为集合.因为集合不能包含重复的值,所以它只有distinct操作
    
    //2.3特殊用法——属性验证
    NSError *error;
    NSString *nameStr = @"小";
    BOOL nameValid = [person validateName:&nameStr error:&error];
    NSString *name = [person valueForKey:@"name"];
    if(nameValid){
        NSLog(@"可以赋值,name=%@",name);
    }else {
        NSLog(@"不可以赋值,name=%@",name);
    }
    /*
     上述用例演示了一个name字符串属性的验证方法，该方法确保值对象的最小长度和不为nil。
     如果验证失败，此方法不会替换其他值。
     */
    
    //- (BOOL)validateValue:(inout id _Nullable * _Nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError
    /*
     这一方法主要是在使用KVC赋值前验证key与Value是否匹配的方法。
     同时这个方法系统不会自动去检测，需要自己调用去检测。
     默认返回YES。
     */
    
    BOOL canValidate = [person validateValue:&nameStr forKey:@"name" error:&error];
    name = [person valueForKey:@"name"];
    if(canValidate){
        NSLog(@"可以赋值，name=%@",name);
    }else {
       NSLog(@"不可以赋值,name=%@",name);
    }
    /* 上面打印：
     yes == 1,ioValueClass == __NSCFConstantString
    可以赋值，name=sepCode
     */

    self.arrayM1 = @[@1,@2,@3,@4].mutableCopy;
    [self.arrayM1 addObject:@12];
    [self.arrayM1 removeLastObject];
    [self.arrayM1 replaceObjectAtIndex:0 withObject:@(4)];
    
    NSMutableArray *kvcArray = [self mutableArrayValueForKey:@"arrayM1"];
    // 发送NSMutableArray消息 与上面三个方法依次对应
    [kvcArray addObject:@(14)];
    [kvcArray removeLastObject];
    [kvcArray replaceObjectAtIndex:2 withObject:@(11)];
    
}
- (void)insertObject:(NSNumber *)object inArrayM1AtIndex:(NSUInteger)index {
    [self.arrayM1 insertObject:object atIndex:index];
}

- (void)removeObjectFromArrayM1AtIndex:(NSUInteger)index {
    [self.arrayM1 removeObjectAtIndex:index];
}
- (void)replaceObjectInArrayM1AtIndex:(NSUInteger)index withObject:(id)object {
    [self.arrayM1 replaceObjectAtIndex:index withObject:object];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self mutableArrayValueForKey:@"arrayM"] addObject:@"4"];
    NSLog(@"arry.count: %ld, arry:%p", self.arrayM.count, self.arrayM);
    
    /*//2.1特殊用法——访问集合属性
     虽然我们可以使用通用的方式访问集合对象，但是，当你想要操纵这些集合的内容时，官方推荐我们最有效的方法是使用协议定义的可变代理方法。
     协议为访问集合对象定义了三种不同的代理方法，每种方法都有key和keyPath变种：
     mutableArrayValueForKey: 和 mutableArrayValueForKeyPath:
     它们返回一个行为类似于NSMutableArray对象的代理对象。
     
     mutableSetValueForKey: 和 mutableSetValueForKeyPath:
     它们返回一个行为类似于NSMutableSet对象的代理对象。
     mutableOrderedSetValueForKey: 和 mutableOrderedSetValueForKeyPath:
     它们返回一个行为类似于NSMutableOrderedSet对象的代理对象。
     */
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    NSLog(@"keyPath: %@", keyPath);
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"arrayM"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
