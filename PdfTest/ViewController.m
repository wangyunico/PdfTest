//
//  ViewController.m
//  PdfTest
//
//  Created by 王宇 on 16/1/11.
//  Copyright © 2016年 王宇. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (assign, nonatomic) IBOutlet UIButton *presentView;
@property(nonatomic,strong) NSString* nextId;
@property(nonatomic,strong) NSString* nextOpId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark -- 崩溃相关
    //    UIView* testObj = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    testObj.backgroundColor = [UIColor whiteColor];
    //    [testObj release];
    //    for (int i = 0; i < 10; i++) {
    //        UIView* testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //        testView.backgroundColor = [UIColor redColor];
    //        [self.view addSubview:testView];
    //        [[NSRunLoop mainRunLoop]runMode:NSDefaultRunLoopMode beforeDate:nil];
    //    }
    //    [testObj setNeedsLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)presentView:(UIButton *)sender {
    
    UIViewController* drawViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.nextOpId];
    [self presentViewController:drawViewController animated:YES completion:nil];
    
    
    
}

-(NSString*)nextId{
    if (_nextId == nil) {
        _nextId = @"drawViewController";
    }
    return _nextId;
}


-(NSString*)nextOpId{
    if (_nextOpId == nil) {
        _nextOpId = @"drawOptimizeViewController";
    }
    return _nextOpId;
}

@end
