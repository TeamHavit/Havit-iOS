//
//  MypageViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

class MypageViewController: BaseViewController {

    private let myPageCategoryView = MyPageDescriptionView()
    private let myPageSaveContentsView = MyPageDescriptionView()
    private let myPageSeenContentsView = MyPageDescriptionView()

    private let reachRateLabel: UILabel = {
        let label = UILabel()
        label.text = "75%"
        label.font = .font(.pretendardSemibold, ofSize: 45)
        label.textColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "해빗도리님은 7일차 해빗러입니다.\n벌써 함께한지 일주일!"
        label.numberOfLines = 2
        label.font = .font(.pretendardReular, ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteGray
        view.layer.cornerRadius = 18
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private let mypagePepleImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgMyPage
        return image
    }()

    private let mypageCornImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgMyPageCorn
        return image
    }()

    private let activityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "해빗도리님의 활동"
        label.font = .font(.pretendardSemibold, ofSize: 20)
        label.textColor = .gray005
        return label
    }()

    private let hStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 13
        stack.alignment = .leading
        stack.distribution = .fillEqually

        return stack
    }()

    // MARK: - init

    override init() {
        super.init()
        setStackView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func render() {
        view.setGradient(colors: [
            UIColor(red: 0.521, green: 0.472, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.415, green: 0.355, blue: 1, alpha: 1).cgColor
          ], locations: [0, 1], startPoint: CGPoint(x: 0.25, y: 0.5), endPoint: CGPoint(x: 0.75, y: 0.5))

        view.addSubViews([reachRateLabel, descriptionLabel, mypagePepleImage, bottomView, mypageCornImage])
        bottomView.addSubViews([activityTitleLabel, hStackView])

        hStackView.addArrangedSubview(myPageCategoryView)
        hStackView.addArrangedSubview(myPageSaveContentsView)
        hStackView.addArrangedSubview(myPageSeenContentsView)

        reachRateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.leading.equalToSuperview().inset(21)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(reachRateLabel.snp.bottom).offset(9)
            $0.leading.equalTo(reachRateLabel.snp.leading)
        }

        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.size.height * (390 / 812))
        }

        mypagePepleImage.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(44)
            $0.bottom.equalTo(bottomView.snp.top).offset(70)
        }

        mypageCornImage.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top).offset(60)
            $0.width.equalTo(112)
            $0.height.equalTo(132)
        }

        activityTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(24)
        }

        hStackView.snp.makeConstraints {
            $0.top.equalTo(activityTitleLabel.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(22)
            $0.trailing.equalToSuperview().inset(22)
        }
    }

    override func configUI() {
        view.backgroundColor = .havitPurple
    }

    func setStackView() {
        myPageCategoryView.iconImageView.image = ImageLiteral.iconMyPageCategory
        myPageSaveContentsView.iconImageView.image = ImageLiteral.iconMyPageSave
        myPageSeenContentsView.iconImageView.image = ImageLiteral.iconMyPageCheck

        myPageCategoryView.titleLabel.text = "카테고리 수"
        myPageSaveContentsView.titleLabel.text = "저장한 콘텐츠"
        myPageSeenContentsView.titleLabel.text = "확인한 콘텐츠"

        myPageCategoryView.countLabel.text = "12개"
        myPageSaveContentsView.countLabel.text = "83개"
        myPageSeenContentsView.countLabel.text = "67개"
    }
}
