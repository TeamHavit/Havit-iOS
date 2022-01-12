//
//  PreviewProvider.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/12.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

enum DeviceType {
    case iPhone8
    case iPhoneSE2
    case iPhone12ProMax
    case iPhone13Mini
    case iPhone13Pro

    func name() -> String {
        switch self {
        case .iPhone8:
            return "iPhone 8"
        case .iPhoneSE2:
            return "iPhone SE (2nd generation)"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        case .iPhone13Mini:
            return "iPhone 13 mini"
        case .iPhone13Pro:
            return "iPhone 13 Pro"
        }
    }
}

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone13Pro) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}

extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone13Pro) -> some View {
        Preview(view: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
