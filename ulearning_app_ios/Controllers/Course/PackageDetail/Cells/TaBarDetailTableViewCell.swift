//
//  TaBarDetailTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 22/09/23.
//

import UIKit

protocol TaBarDetailTableViewCellProtocol: AnyObject {
    
}

class TaBarDetailTableViewCell: UITableViewCell {

    var delegate: TaBarDetailTableViewCellProtocol?

    
    @IBOutlet weak var courseCollection: UICollectionView!{
        didSet {
            courseCollection.register(
                ULCourseTableViewCell().nib,
                forCellWithReuseIdentifier: String(describing: ULCourseTableViewCell.self)
            )
            courseCollection.delegate = self
            courseCollection.dataSource = self
        }
    }
    
    
    @IBOutlet weak var coursesButton: UIButton!{
        didSet {
            coursesButton.tag = 1
            coursesButton.addTarget(
                self,
                action: #selector(selectTabButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var descriptionButton: UIButton!{
        didSet {
            descriptionButton.tag = 2
            descriptionButton.addTarget(
                self,
                action: #selector(selectTabButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var selectListTab: UIView!{
        didSet {
            selectListTab.isHidden = false
        }
    }
    
    @IBOutlet weak var selectDetailTab: UIView!{
        didSet {
            selectDetailTab.isHidden = true
        }
    }
    
    @IBOutlet weak var listContainer: UIView!{
        didSet {
            listContainer.isHidden = false
        }
    }
    
    @IBOutlet weak var detailContainer: UIView!
    {
        didSet {
            detailContainer.isHidden = true
        }
    }
    

    @IBOutlet weak var shortDescriptionText: UITextView!{
        didSet {
            shortDescriptionText.font = UIFont.boldSystemFont(ofSize: 10)
            shortDescriptionText.textColor = .blackUL
            shortDescriptionText.isUserInteractionEnabled = false
            shortDescriptionText.dataDetectorTypes = .link
            shortDescriptionText.isScrollEnabled = false
            shortDescriptionText.sizeToFit()
        }
    }
    
    @IBOutlet weak var largeDescriptionText: UITextView!{
        didSet {
            largeDescriptionText.font = UIFont.boldSystemFont(ofSize: 10)
            largeDescriptionText.textColor = .blackUL
            largeDescriptionText.isUserInteractionEnabled = false
            largeDescriptionText.dataDetectorTypes = .link
            largeDescriptionText.isScrollEnabled = false
            largeDescriptionText.sizeToFit()
        }
    }
    
    
    public let nib = UINib(
        nibName: String(describing: TaBarDetailTableViewCell.self),
        bundle: nil
    )

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func selectTabButton(_ sender: UIButton) {

        let isCourseTab = sender.tag == 1
        if isCourseTab {
            listContainer.isHidden = false
            selectListTab.isHidden = false
            detailContainer.isHidden = true
            selectDetailTab.isHidden = true
        } else {
            listContainer.isHidden = true
            selectListTab.isHidden = true
            detailContainer.isHidden = false
            selectDetailTab.isHidden = false
        }
    }
    
    
    func setupCell(data: ULSubscription?, delegate: TaBarDetailTableViewCellProtocol) {
        self.delegate = delegate
        
        let paragraphDescriptionContent = NSMutableParagraphStyle()
        paragraphDescriptionContent.lineHeightMultiple = 1.22
        
        var largeDescription = ""
        if let plainString = parseHTMLToPlainString(html: data?.learningPackage?.descriptionLarge ?? "") {
            largeDescription = plainString
            print(plainString)
        }
        
        largeDescriptionText.attributedText = NSMutableAttributedString(
            string: largeDescription,
            attributes: [
                .paragraphStyle: paragraphDescriptionContent
            ]
        )
        
        
        var shortDescription = ""
        if let plainString = parseHTMLToPlainString(html: data?.learningPackage?.descriptionShort ?? "") {
            shortDescription = plainString
            print(plainString)
        }
        
        shortDescriptionText.attributedText = NSMutableAttributedString(
            string: shortDescription,
            attributes: [
                .paragraphStyle: paragraphDescriptionContent
            ]
        )
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
