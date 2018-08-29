//
//  WeatherTableViewCell.swift
//  MetaWeather
//
//  Created by Admin on 8/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherTableViewCell: UITableViewCell{
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: WeatherCellViewModel){
        
        self.weatherLabel.text = viewModel.weatherLabelText()
        
        if let urlString = viewModel.weatherImageURL(){
            if let url = URL(string: urlString){
                self.weatherImage.kf.setImage(with: url)
            }
            else {
                self.weatherImage.image = nil
            }
        }
        else {
            self.weatherImage.image = nil
        }
        
        self.lowLabel.text = viewModel.lowLabelText()
        self.highLabel.text = viewModel.highLabelText()
        self.locationLabel.text = viewModel.locationLabelText()
        
        self.dateLabel.text = viewModel.dateLabelText()
        self.humidityLabel.text = viewModel.humidityLabelText()
    }

    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
