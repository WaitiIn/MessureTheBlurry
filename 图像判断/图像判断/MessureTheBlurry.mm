//
//  MessureTheBlurry.m
//  图像模糊度判断Demo
//
//  Created by 于玮 on 15/12/25.
//  Copyright © 2015年 于玮. All rights reserved.
//
#import "opencv2/opencv.hpp"
#import "opencv2/imgproc/types_c.h"
#import "opencv2/imgcodecs/ios.h"
#import "opencv2/highgui.hpp"
#import "MessureTheBlurry.h"
@implementation MessureTheBlurry
+(double)messureTheBlurryOfImageName:(NSString *)imageName{

    cv::Mat cvImage;
    UIImage *image = [UIImage imageNamed:imageName];
    if (image==nil) {
        NSLog(@"不存在该图片");
        return 0;
    }
    UIImageToMat(image,cvImage);
    cv::Mat gray;
    cv::cvtColor(cvImage,cvImage, CV_RGB2GRAY);//彩色转灰度
    cv::Laplacian(cvImage,gray,cvImage.depth());//laplace变换
    IplImage ipl_image(gray);
    unsigned char *data;
    int height,width,step;
    height = ipl_image.height;
    width  = ipl_image.width;
    step   = ipl_image.widthStep;
    data   = (uchar*)ipl_image.imageData;
    int Iij;
    
    double Imax = 0.0, Imin = 255.0, Iave = 0, Idelta = 0;
    
    for(int i=0;i<height;i++)
    {
        for(int j=0;j<width;j++)
        {
            Iij	= (int) data[i*width+j];
            if(Iij > Imax)
                Imax = Iij;
            if(Iij < Imin)
                Imin = Iij;
            Iave = Iave + Iij;
        }
    }
    Iave = Iave/(width*height);
    for(int i=0;i<height;i++)
    {
        for(int j=0;j<width;j++)
        {
            Iij	= (int) data
            [i*width+j];
            Idelta	= Idelta + (Iij-Iave)*(Iij-Iave);
        }
    }
    if(width*height == 0){
        NSLog(@"图片非法");
        return 0;
    }else{
    Idelta = Idelta/(width*height);
    printf("灰度最大值   = %f\n",Imax);
    printf("灰度最小值   = %f\n",Imin);
    printf("灰度均值     = %f\n",Iave);
    printf("灰度方差     = %f\n",Idelta);
    
    return Idelta;
    }
}
@end
