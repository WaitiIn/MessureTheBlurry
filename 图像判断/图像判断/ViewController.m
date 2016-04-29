//
//  ViewController.m
//  图像判断
//
//  Created by 于玮 on 16/4/29.
//  Copyright © 2016年 于玮. All rights reserved.
//

#import "ViewController.h"
#import "MessureTheBlurry.h"
#define Threshold 80
@interface ViewController()
@property (nonatomic)  UIImageView *imageView;
@property (nonatomic)  UIButton    *next;
@property (nonatomic)  UILabel     *blurry;
@property NSInteger page;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 0;
    self.imageView.frame = self.view.frame;
    self.next.frame = CGRectMake(100, self.view.frame.size.height-40, 100, 40);
    [self.view addSubview:self.next];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.blurry];
    [self nextImage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)nextImage{
    NSLog(@"下一个图");
    NSString *str;
    if (++_page == 20) {
        _page=1;
    }
    NSString *imageName =[NSString stringWithFormat:@"%ld",_page];
    UIImage *image = [UIImage imageNamed:imageName];
    _imageView.image = image;
    double blurry = [MessureTheBlurry messureTheBlurryOfImageName:imageName];

    if (blurry > Threshold) {
        NSLog(@"清晰");
        str=@"清晰";
    }
    else{
        NSLog(@"模糊");
        str = @"模糊";
    }
    _blurry.text = [NSString stringWithFormat:@"blurry:%f\n结果判定（以%d为阈值）：%@",blurry,Threshold,str];
    NSLog(@"//////////////////////////////////////////////");

}
#pragma mark - getter
-(UIButton *)next{
    if (_next == nil) {
        _next = [[UIButton alloc]init];
        [_next addTarget:self action:@selector(nextImage) forControlEvents:UIControlEventTouchUpInside];
        [_next setTitle:@"next" forState:UIControlStateNormal];
        [_next setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return _next;
}
-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
-(UILabel *)blurry{
    if (_blurry == nil) {
        _blurry = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        _blurry.textColor = [UIColor redColor];
        _blurry.numberOfLines = 0;
    }
    return _blurry;
}

@end
