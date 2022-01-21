//
//  SaveContentsViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import Kingfisher
import SnapKit

final class SaveContentsViewController: BaseViewController {
    
    // MARK: - property
    
    var selectedCategoryIds: [Int] = []
    
    var targetContent: TargetContent?
    
    private let navigationLeftButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: ImageLiteral.btnBackBlack,
                                            style: .plain,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private let navigationRightButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private var contentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgDummyContent
        return imageView
    }()
    
    private var contentsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "콘텐츠 제목은 우리 몇글자까지 할까o.. 어카지어카지"
        label.font = .font(.pretendardSemibold, ofSize: 20)
        label.textColor = .gray004
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private var contentsUrlLabel: UILabel = {
        let label = UILabel()
        label.text = "m.blog.naver.com"
        label.font = .font(.pretendardSemibold, ofSize: 12)
        label.textColor = .gray002
        label.textAlignment = .center
        return label
    }()
    
    private let editTitleButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = .font(.pretendardMedium, ofSize: 14)
        configuration.attributedTitle = AttributedString("제목 수정", attributes: container)
        configuration.baseForegroundColor = UIColor.gray002
        configuration.background.backgroundColor = .gray000
        configuration.image = ImageLiteral.iconShareEdit
        configuration.imagePlacement = .leading
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 9, bottom: 4, trailing: 11)

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private let alarmConfigButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 15)
        configuration.attributedTitle = AttributedString("알림 설정", attributes: container)
        configuration.baseForegroundColor = UIColor.havitPurple
        configuration.background = .clear()
        configuration.image = ImageLiteral.iconShareAlarm
        configuration.imagePadding = 2
        configuration.imagePlacement = .leading
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 9, bottom: 4, trailing: 11)

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private let completeButton: UIButton = {
        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("완료", attributes: container)
        configuration.background.cornerRadius = 0
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .havitPurple
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 173, bottom: 44, trailing: 174)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - func
    
    override func configUI() {
        view.backgroundColor = .white
        setNavigationBar()
        self.contentsTitleLabel.text = targetContent?.title
        self.contentsUrlLabel.text = targetContent?.contentUrl
        setImage()
    }
    
    override func render() {
        view.addSubViews([contentsImageView,
                          contentsTitleLabel,
                          contentsUrlLabel,
                          editTitleButton,
                          alarmConfigButton,
                          completeButton])
        
        contentsImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
            $0.leading.trailing.equalToSuperview().inset(34)
            $0.height.equalTo(173)
        }
        
        contentsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentsImageView.snp.bottom).offset(27)
            $0.leading.trailing.equalTo(contentsImageView)
        }
        
        contentsUrlLabel.snp.makeConstraints {
            $0.top.equalTo(contentsTitleLabel.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        editTitleButton.snp.makeConstraints {
            $0.top.equalTo(contentsUrlLabel.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
        }
        
        alarmConfigButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(completeButton.snp.top).offset(-38)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(84)
        }
    }
    
    private func setNavigationBar() {
        title = "콘텐츠 저장"
        navigationItem.leftBarButtonItem = navigationLeftButton
        // navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func setImage() {
        if let imageUrl = targetContent?.ogImage,
           let url = URL(string: imageUrl) {
            contentsImageView.kf.setImage(with: url)
        }
    }
}
