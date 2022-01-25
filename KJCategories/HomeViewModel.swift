//
//  HomeViewModel.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import Foundation
import UIKit

enum ViewControllerType: String {
    case Opencv = "Opencv image processing"
    case EmitterAnimation = "Particle opening animation"
    case Animation = "Test basic animation display"
    case Projection = "Projection effect processing"
    case Shadow = "Luminous display inside and outside"
    case FloodImage = "Flood Image Algorithm Exhibition"
    case GradientSlider = "Rainbow gradient color slider"
    case BezierPath = "Bezier Path Curve"
    case Button = "Button graphic layout like particles"
    case Label = "Text multi-angle display"
    case TextField = "Input box construction"
    case TextView = "Restrict input box cancellation"
    case QRCode = "QR code generator"
    
    func viewController() -> UIViewController {
        switch self {
        case .Opencv:
            return OpencvViewController()
        case .EmitterAnimation:
            return EmitterAnimationViewController()
        case .Animation:
            return AnimationViewController()
        case .Projection:
            return ProjectionViewController()
        case .Shadow:
            return ShadowViewController()
        case .FloodImage:
            return FloodImageVieController()
        case .GradientSlider:
            return GradientSliderViewController()
        case .BezierPath:
            return BezierPathViewController()
        case .Button:
            return ButtonViewController()
        case .Label:
            return LabelViewController()
        case .TextField:
            return TextFieldViewController()
        case .TextView:
            return TextViewController()
        case .QRCode:
            return QRCodeViewController()
        }
    }
}

class HomeViewModel: NSObject {
    
    lazy var datas: [ViewControllerType] = {
        return [
            .Opencv,
            .EmitterAnimation,
            .Animation,
            .Projection,
            .Shadow,
            .FloodImage,
            .GradientSlider,
            .BezierPath,
            .Button,
            .Label,
            .TextField,
            .TextView,
            .QRCode,
        ]
    }()
}
