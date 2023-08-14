//
//  ULDetailComponentTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/08/23.
//

import UIKit

protocol DetailComponentTableViewCellProtocol: AnyObject {
    func closeButtonPress(sender: UIButton, cell: DetailComponentTableViewCell)
}

class DetailComponentTableViewCell: UITableViewCell {

    @IBAction func backBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var backPressBtn: UIButton!{
        didSet {
            backPressBtn.setTitle("", for: .normal)
            backPressBtn.setTitle("", for: .selected)
            backPressBtn.setTitle("", for: .focused)
            backPressBtn.addTarget(
                self,
                action: #selector(closeButtonPress(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var containerBtnGoToMessage: UIView!{
        didSet {
            containerBtnGoToMessage.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var courseaImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView! {
        didSet {
            descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
            descriptionLabel.textColor = .blackUL
            descriptionLabel.isUserInteractionEnabled = true
            descriptionLabel.dataDetectorTypes = .link
            descriptionLabel.isSelectable = true
            descriptionLabel.isEditable = false
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!{
        didSet {
            descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
            descriptionLabel.textColor = .blackUL
        }
    }
    
    
    @IBOutlet weak var modeLabel: UILabel!{
        didSet {
            descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
            descriptionLabel.textColor = .blackUL
        }
    }
    
    @IBOutlet weak var sessionLabel: UILabel!{
        didSet {
            descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
            descriptionLabel.textColor = .blackUL
        }
    }
    
    
    
    @IBAction func goToMessageBtn(_ sender: Any) {
    }
    
    var delegate: DetailComponentTableViewCellProtocol?

    
    public let nib = UINib(
        nibName: String(describing: DetailComponentTableViewCell.self),
        bundle: nil
    )

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(data: ULSubscription, delegate: DetailComponentTableViewCellProtocol) {
        self.delegate = delegate
        print("DetailComponentTableViewCellProtocoll \(data.course?.title)")

        titleLabel.attributedText = NSMutableAttributedString(
            string: data.course?.title ?? "text",
            attributes: [
                .kern: -0.46,
            ]
        )
        var descriptionLarge = ""
        if let plainString = parseHTMLToPlainString(html: data.course?.descriptionLarge ?? "") {
            descriptionLarge = plainString
            print(plainString)
        }
        
        let paragraphDescriptionContent = NSMutableParagraphStyle()
        paragraphDescriptionContent.lineHeightMultiple = 1.22
        descriptionLabel.attributedText = NSMutableAttributedString(
            string: descriptionLarge,
            attributes: [
                .paragraphStyle: paragraphDescriptionContent
            ]
        )
        
        var selfStudyHour = "--"
        if let hour = data.course?.selfStudyHour {
            selfStudyHour = String(hour.self)
        }
        timeLabel.text = "\(selfStudyHour) hr"
        modeLabel.text = data.course?.formatModality()
        
        var formattedCount = "--"
        if let lessonsCount = data.course?.lessonsCount {
            formattedCount = String(lessonsCount.self)
        }
        sessionLabel.text = formattedCount
        
        
        
    }
    
    @objc func closeButtonPress(_ sender: UIButton) {
        self.delegate?.closeButtonPress(sender: sender, cell: self)
    }
    
    func parseHTMLToPlainString(html: String) -> String? {
        guard let data = html.data(using: .utf8) else {
            return nil
        }
        
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error parsing HTML: \(error)")
            return nil
        }
    }
    
}
