//
//  TableViewCell.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/01.
//

/*import UIKit
import RealmSwift



class TweetTableViewCell: UITableViewCell {
   
    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var tweetImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var ratingLabel:UILabel!
   /* @IBOutlet weak var minusButton: UIButton!*/
    /*@IBOutlet var deleteButton: UIButton!
    var deleteButtonAction: (() -> Void)?*/
   
    
    /*weak var delegate: TweetTableViewCellDelegate?*/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setTweet(tweetText: String?, tweetImageFileName: String?, rating: Float?) {
        profileImageView.layer.cornerRadius = 25
        ratingLabel.text = "評価" + String(describing: rating)
        tweetTextLabel.text = tweetText
        
        tweetImageView.image = nil
        if let tweetImageName = tweetImageFileName{
            let tweetImageURL = tweetImageName.convertStringToURL()
            tweetImageView.image = tweetImageURL.getimageformURL()
        }
    }
    /*@IBAction func deleteButtonTapped(_ sender: UIButton){
        deleteButtonAction?()
    }*/
   /* @IBAction func minusButtonTapped(_ sender: UIButton) {
            // TableViewのデリゲートメソッドを呼び出して、削除を要求する
            if let tableView = self.superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
                delegate?.minusButtonTapped(in: self)
            }
        }

*/
   /* @IBAction func minusButtonTapped(_ sender: UIButton) {
           delegate?.didTapMinusButton(in: self)
       }*/
    /*@IBAction func minusButtonTapped(_ sender: UIButton) {
         delegate?.minusButtonTapped(in: self)
     }*/
}
*/
import UIKit
import RealmSwift



class TweetTableViewCell: UITableViewCell {
   
    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var tweetImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var ratingLabel:UILabel!
   /* @IBOutlet weak var minusButton: UIButton!*/
    /*@IBOutlet var deleteButton: UIButton!
    var deleteButtonAction: (() -> Void)?*/
   
    
    /*weak var delegate: TweetTableViewCellDelegate?*/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setTweet(tweetText: String?, tweetImageFileName: String?, rating: Float?) {
        profileImageView.layer.cornerRadius = 25
       ratingLabel.text = String(describing: rating)

        tweetTextLabel.text = tweetText
        
        tweetImageView.image = nil
        if let tweetImageName = tweetImageFileName{
            let tweetImageURL = tweetImageName.convertStringToURL()
            tweetImageView.image = tweetImageURL.getimageformURL()
        }
    }
    /*@IBAction func deleteButtonTapped(_ sender: UIButton){
        deleteButtonAction?()
    }*/
   /* @IBAction func minusButtonTapped(_ sender: UIButton) {
            // TableViewのデリゲートメソッドを呼び出して、削除を要求する
            if let tableView = self.superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
                delegate?.minusButtonTapped(in: self)
            }
        }

*/
   /* @IBAction func minusButtonTapped(_ sender: UIButton) {
           delegate?.didTapMinusButton(in: self)
       }*/
    /*@IBAction func minusButtonTapped(_ sender: UIButton) {
         delegate?.minusButtonTapped(in: self)
     }*/
}

