//
//  DetailViewController.swift
//  Demo
//
//  Created by Đừng xóa on 8/24/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var place: PlacesVietNam?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if place != nil {
            nameLabel.text = place?.name
            urlLabel.text = place?.image
            contentLabel.text = place?.content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
