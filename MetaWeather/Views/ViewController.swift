//
//  ViewController.swift
//  MetaWeather
//
//  Created by Admin on 8/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    let viewModel = WeatherViewModel()

    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        viewModel.delegate = self
        viewModel.setWeather()
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.viewModel.weatherModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        cell.configure(viewModel: self.viewModel.weatherModels[indexPath.row])
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return self.view.frame.size.height / 6.2
    }
    
}

extension ViewController: WeatherDelegate{
    
    func updateTable(){
        DispatchQueue.main.async{
            self.weatherTableView.reloadData()
        }
    }
    
}

