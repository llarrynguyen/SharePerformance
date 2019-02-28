//
//  SPNewsViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPNewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SPNewsViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.newsViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.news
    }
    
    var viewModel: Any? {
        return SPNewsViewModel()
        
    }
    
    func setupViewController() {
        //
    }
}
