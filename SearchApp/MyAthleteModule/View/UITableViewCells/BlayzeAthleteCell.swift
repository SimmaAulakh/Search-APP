//
//  BlayzeAthleteCell.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import UIKit

protocol BlayzeAthleteCellDelegate {
    func deleteRecentSearchHistory(_ index: Int)
}

class BlayzeAthleteCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var blayzeImgView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: - Variabels
    var delegate: BlayzeAthleteCellDelegate?
    var athleteType: AthleteType? {
        didSet {
            blayzeImgView.isHidden = athleteType == .Recruits
            timeLabel.isHidden = athleteType == .Recruits
        }
    }
    
    var searchedText: String?
    var setData: Athlete? {
        didSet{
            if let user = setData{
                avtarImageView.image = UIImage(named: user.image)
                nameLabel.text = user.name
                positionLabel.text = user.position
                timeLabel.text = user.time ?? ""
                blayzeImgView.isHidden = user.type == .Recruits
                timeLabel.textColor = setTimeLabelColorAccordingToPriority(priority: user.messagePriority)
                deleteButton.isHidden = (user.isRecentSearch ?? false) ? false : true
                if let searchedText = searchedText {
                    nameLabel.highlightSearchedText(text:user.name , searchedText: searchedText)
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTimeLabelColorAccordingToPriority(priority: MessagePriority?) -> UIColor {
        switch priority {
        case .high: return .red
        case .medium: return .orange
        case .low: return Constants.AppColors.appGrayColor
        case .none: return Constants.AppColors.appGrayColor
        }
    }
    
    //MARK: - IBActions
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        delegate?.deleteRecentSearchHistory(sender.tag)
    }
}


