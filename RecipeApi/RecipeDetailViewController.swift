//
//  RecipeDetailViewController.swift
//  RecipeApi
//
//  Created by Geek on 10/6/20.
//  Copyright © 2020 Geek. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var recipe = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Do any additional setup after loading the view.
    }
    
    init(recipeDetail: NSDictionary){
        self.recipe = recipeDetail
        super.init(nibName: nil, bundle: nil)
        if(recipe["image"] != nil){
            if let imageURL = URL(string: recipe["image"] as! String) {
                // create network request
                let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                
                    if error == nil {
                        // create image
                        let downloadedImage = UIImage(data: data!)
                        // update UI on a main thread
                        DispatchQueue.main.async{
                            self.imageView?.image = downloadedImage
                        }
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
