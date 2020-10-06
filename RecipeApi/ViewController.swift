//
//  ViewController.swift
//  RecipeApi
//
//  Created by Geek on 10/4/20.
//  Copyright © 2020 Geek. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var recipe = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getRecipe()
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipeDetail = recipe[indexPath.row] as! NSDictionary
        let vc = RecipeDetailViewController(recipeDetail: recipeDetail)
        vc.recipe = recipeDetail

    }
}

extension ViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath )
        let recipeDetails = recipe[indexPath.row] as! NSDictionary
        cell.textLabel?.text = recipeDetails["label"] as! String
        return cell
    }
    
    func getRecipe() {
        var recipeArray = [NSDictionary]()
        let url = URL(string: "https://api.edamam.com/search?q=chicken&app_id=0d3d3583&app_key=3af486c6f67a782f8a2e5b6a1913757e")!
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    for jsonHits in JSON["hits"] as! NSArray{
                        let hits = jsonHits as! NSDictionary
                        recipeArray.append(hits["recipe"] as! NSDictionary)
                    }
                    self.recipe = recipeArray
                    self.tableView.reloadData()
                }
        }
    }
}



