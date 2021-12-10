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
            ["class": "HoughViewController", "describeName": "Hough line detection and correction text"],
            ["class": "SobelViewController", "describeName": "Feature Extraction Processing"],
            ["class": "RepairViewController", "describeName": "Old photo repair"],
            ["class": "InpaintViewController", "describeName": "Repair the picture to remove the watermark"],
            ["class": "MaxCutViewController", "describeName": "Maximum Area Cut"],
            ["class": "MorphologyViewController", "describeName": "Morphology Operation"],
            ["class": "BlurViewController", "describeName": "Blurred skin whitening treatment"],
            ["class": "WarpPerspectiveViewController", "describeName": "Picture Perspective"],
            ["class": "ImageBlendViewController", "describeName": "Picture Blend"],
            ["class": "LuminanceViewController", "describeName": "Modify brightness and contrast"],
            ["class": "TiledViewController", "describeName": "Picture mosaic tile"],
        ]
    }()
    
}
