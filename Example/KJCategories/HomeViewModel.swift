//
//  HomeViewModel.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import Foundation

enum ViewControllerType: String {
    case Opencv = "Opencv image processing"
    case EmitterAnimation = "Particle opening animation"
    case Animation = "Test basic animation display"
    case FloodImage = "Flood Image Algorithm Exhibition"
    case GradientSlider = "Rainbow gradient color slider"
    case BezierPath = "Bezier Path Curve"
    case Button = "Button graphic layout like particles"
    case Label = "Text multi-angle display"
    case TextField = "Input box construction"
    case TextView = "Restrict input box cancellation"
    
    func viewController() -> UIViewController {
        switch self {
        case .Opencv: return OpencvViewController()
        case .EmitterAnimation: return EmitterAnimationViewController()
        case .Animation: return AnimationViewController()
        case .FloodImage: return FloodImageVieController()
        case .GradientSlider: return GradientSliderViewController()
        case .BezierPath: return BezierPathViewController()
        case .Button: return ButtonViewController()
        case .Label: return LabelViewController()
        case .TextField: return TextFieldViewController()
        case .TextView: return TextViewController()
        //default: return BaseViewController()
        }
    }
}

class HomeViewModel: NSObject {
    
    lazy var datas: [ViewControllerType] = {
        return [
            .Opencv,
            .EmitterAnimation,
            .Animation,
            .FloodImage,
            .GradientSlider,
            .BezierPath,
            .Button,
            .Label,
            .TextField,
            .TextView,
        ]
    }()
}
