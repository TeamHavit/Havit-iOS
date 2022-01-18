//
//  HavitTabBar.swift
//  Havit
//
//  Created by 강수진 on 2022/01/18.
//

import UIKit

import SnapKit

final class HavitTabBar: UIView {
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let safeAreaBottom: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? .zero
        static let systemTabBarHeight: CGFloat = 49
        static let tabBarHeight: CGFloat = systemTabBarHeight + safeAreaBottom
        static let tabBarButtonCenterY = systemTabBarHeight / 2
        
        static let addButtonInset: CGFloat = 4
        static let addButtonSize = CGSize(width: 52,
                                          height: 52)
        static let addButtonSizeWithInset: CGSize = {
            let insets = addButtonInset * 2
            let addButtonSizeWithInset = CGSize(width: addButtonSize.width + insets,
                                                height: addButtonSize.height + insets)
            return addButtonSizeWithInset
        }()
        static let addButtonRadiusWithInset: CGFloat = addButtonSizeWithInset.width / 2
        static let addButtonTrailing: CGFloat = 20
        static let addButtonStartX = screenWidth - addButtonTrailing - addButtonSizeWithInset.width
        static let addButtonCenterX = screenWidth - addButtonTrailing - addButtonRadiusWithInset
    }

    // MARK: - property
    
    private let havitTabBarBlackBackgroundView = HavitTabBarBlackBackgroundView()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiteral.iconHomeSelected, for: .normal)
        return button
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiteral.iconCategoryUnselected, for: .normal)
        return button
    }()
    
    private let myPageButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiteral.iconMypageUnselected, for: .normal)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiteral.btnAdd, for: .normal)
        button.applyZeplinShadow(color: .black,
                                 alpha: 0.25,
                                 x: 0,
                                 y: 4,
                                 blur: 4,
                                 spread: 0)
        return button
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(havitTabBarBlackBackgroundView)
        havitTabBarBlackBackgroundView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
       
        let tabBarbuttons = [homeButton, categoryButton, myPageButton]
        let containerWidthPerTabBarButton = Size.addButtonStartX / CGFloat(tabBarbuttons.count)
        
        tabBarbuttons.enumerated().forEach { (index, button) in
            havitTabBarBlackBackgroundView.addSubview(button)
            button.snp.makeConstraints {
                let centerX = (containerWidthPerTabBarButton * CGFloat(index)) + (containerWidthPerTabBarButton / 2)
                $0.centerX.equalTo(centerX)
                $0.centerY.equalTo(Size.tabBarButtonCenterY)
            }
        }
        
        self.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.size.equalTo(Size.addButtonSize)
            $0.centerX.equalTo(Size.addButtonCenterX)
            $0.centerY.equalTo(havitTabBarBlackBackgroundView.snp.top)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class HavitTabBarBlackBackgroundView: UIView {
    
    // MARK: - property
    
    private var shapeLayer: CALayer?

    // MARK: - life cycle
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }

    // MARK: - func
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPathCircle()
        shapeLayer.fillColor = UIColor.black.cgColor

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPathCircle() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: HavitTabBar.Size.addButtonStartX, y: 0)) // the beginning of the trough
        path.addArc(withCenter: CGPoint(x: HavitTabBar.Size.addButtonCenterX, y: 0),
                    radius: HavitTabBar.Size.addButtonRadiusWithInset,
                    startAngle: CGFloat(180).degreesToRadians,
                    endAngle: CGFloat(0).degreesToRadians,
                    clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
}

fileprivate extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
}
