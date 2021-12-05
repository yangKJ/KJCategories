//
//  OpencvViewModel.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit

class OpencvViewModel: NSObject {
    
     @objc public lazy var datas: [NSDictionary] = {
        return [
            ["class": "HoughViewController", "describeName": "霍夫线检测矫正文本"],
            ["class": "SobelViewController", "describeName": "特征提取处理"],
            ["class": "RepairViewController", "describeName": "老照片修复"],
            ["class": "InpaintViewController", "describeName": "修复图片去水印"],
            ["class": "MaxCutViewController", "describeName": "最大区域裁剪"],
            ["class": "MorphologyViewController", "describeName": "形态学操作"],
            ["class": "BlurViewController", "describeName": "模糊磨皮美白处理"],
            ["class": "WarpPerspectiveViewController", "describeName": "图片透视"],
            ["class": "ImageBlendViewController", "describeName": "图片混合"],
            ["class": "LuminanceViewController", "describeName": "修改亮度和对比度"],
            ["class": "TiledViewController", "describeName": "图片拼接平铺"],
        ]
    }()
    
}
