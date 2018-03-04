//
//  PinMakerView.swift
//  DrivingWeather
//
//  Created by Alex St George on 2018-01-27.
//  Copyright © 2018 Pelmorex Media Inc. All rights reserved.
//

import Foundation
import UIKit

class PinMakerView: UIView {
    var alertLabel: UILabel!
    
    var visibilityButton: UIButton!
    var roadCButton: UIButton!
    var extremeButton: UIButton!
    
    var visibilityLabel: UILabel!
    var roadCLabel: UILabel!
    var extremeLabel: UILabel!
    
    var severityLabel: UILabel!
    
    var lowSeverityButton: UIButton!
    var medSeverityButton: UIButton!
    var highSeverityButton: UIButton!
    
    var lowSeverityLabel: UILabel!
    var medSeverityLabel: UILabel!
    var highSeverityLabel: UILabel!
    
    var detailsLabel: UILabel!
    
    var causeLabel: UILabel!
    var causeTextField: UITextField!
    
    var otherLabel: UILabel!
    var otherTextView: UITextField!
    
    var saveButton: UIButton!
    var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        let buttonSize: CGFloat = 50
        
        let labelFont = UIFont(name: Constants.FontName, size: 14)
        let detailsFont = UIFont(name: Constants.FontName, size: 16)
        let titleFont = UIFont(name: Constants.FontName, size: 20)
        
        let textColour = UIColor(red: 222/255.0, green: 240/255.0, blue: 254/255.0, alpha: 1)
        let backgroundColour1 = UIColor(red: 72/255.0, green: 137/255.0, blue: 199/255.0, alpha: 0.9)
        let backgroundColour2 = UIColor(red: 99/255.0, green: 167/255.0, blue: 230/255.0, alpha: 0.9)
        
        let alertView = UIView(frame: CGRect(x: 5, y: 5, width: frame.width-10, height: 115))
        alertView.backgroundColor = backgroundColour1
        let severityView = UIView(frame: CGRect(x: 5, y: alertView.frame.size.height+10, width: frame.width-10, height: 115))
        severityView.backgroundColor = backgroundColour2
        let detailsView = UIView(frame: CGRect(x: 5, y: severityView.frame.origin.y + 120, width: frame.width-10, height: 140))
        detailsView.backgroundColor = backgroundColour1
        
        //Alert Views
        alertLabel = UILabel(frame: CGRect(x: 10, y: 5, width: frame.size.width-20, height: 30))
        alertLabel.text = "Alert Type"
        alertLabel.font = titleFont
        alertLabel.textColor = textColour
        alertLabel.textAlignment = .center
        
        roadCButton = UIButton(frame: CGRect(x: frame.size.width/2 - buttonSize/2, y: alertLabel.frame.size.height + 5, width: buttonSize, height: buttonSize))
        roadCButton.setBackgroundImage(#imageLiteral(resourceName: "RoadCondition"), for: .normal)
        
        visibilityButton = UIButton(frame: CGRect(x: roadCButton.frame.origin.x - buttonSize*5/4, y: alertLabel.frame.size.height + 5, width: buttonSize, height: buttonSize))
        visibilityButton.setBackgroundImage(#imageLiteral(resourceName: "Visibility"), for: .normal)
        
        extremeButton = UIButton(frame: CGRect(x: roadCButton.frame.origin.x + buttonSize*5/4, y: alertLabel.frame.size.height + 5, width: buttonSize, height: buttonSize))
        extremeButton.setBackgroundImage(#imageLiteral(resourceName: "Extreme"), for: .normal)
        
        roadCLabel = UILabel(frame: CGRect(x: frame.size.width/2 - buttonSize/2-10, y: roadCButton.frame.origin.y + buttonSize-5, width: buttonSize+20, height: 40))
        roadCLabel.text = "Road Conditions"
        roadCLabel.numberOfLines = 2
        roadCLabel.font = labelFont
        roadCLabel.textColor = textColour
        roadCLabel.textAlignment = .center
        
        visibilityLabel = UILabel(frame: CGRect(x: roadCButton.frame.origin.x - buttonSize*5/4-12, y: roadCLabel.frame.origin.y + 10, width: buttonSize + 20, height: 20))
        visibilityLabel.text = "Visibility"
        visibilityLabel.font = labelFont
        visibilityLabel.textColor = textColour
        visibilityLabel.textAlignment = .center
        
        extremeLabel = UILabel(frame: CGRect(x: roadCButton.frame.origin.x + buttonSize*5/4-12, y: visibilityLabel.frame.origin.y, width: buttonSize + 20, height: 20))
        extremeLabel.text = "Extreme"
        extremeLabel.font = labelFont
        extremeLabel.textColor = textColour
        extremeLabel.textAlignment = .center
        
        //Severity Views
        severityLabel = UILabel(frame:CGRect(x: 0, y: roadCLabel.frame.origin.y + 40 + 5, width: frame.width, height: 30))
        severityLabel.text = "Severity"
        severityLabel.font = titleFont
        severityLabel.textColor = textColour
        severityLabel.textAlignment = .center
        
        medSeverityButton = UIButton(frame: CGRect(x: frame.size.width/2 - buttonSize/2, y: severityLabel.frame.size.height + severityLabel.frame.origin.y, width: buttonSize, height: buttonSize))
        medSeverityButton.setBackgroundImage(#imageLiteral(resourceName: "MedSeverity"), for: .normal)
        
        lowSeverityButton = UIButton(frame: CGRect(x: roadCButton.frame.origin.x - buttonSize*5/4-10, y: medSeverityButton.frame.origin.y-10, width: buttonSize, height: buttonSize))
        lowSeverityButton.setBackgroundImage(#imageLiteral(resourceName: "LowSeverity"), for: .normal)
        
        highSeverityButton = UIButton(frame: CGRect(x: roadCButton.frame.origin.x + buttonSize*5/4+10, y: medSeverityButton.frame.origin.y, width: buttonSize, height: buttonSize))
        highSeverityButton.setBackgroundImage(#imageLiteral(resourceName: "HighSeverity"), for: .normal)
        
        medSeverityLabel = UILabel(frame: CGRect(x: frame.size.width/2 - buttonSize/2-10, y: lowSeverityButton.frame.origin.y + buttonSize+8, width: buttonSize+20, height: 20))
        medSeverityLabel.text = "Medium"
        medSeverityLabel.numberOfLines = 2
        medSeverityLabel.font = labelFont
        medSeverityLabel.textColor = textColour
        medSeverityLabel.textAlignment = .center
        
        lowSeverityLabel = UILabel(frame: CGRect(x: roadCButton.frame.origin.x - buttonSize*5/4-22, y: medSeverityLabel.frame.origin.y, width: buttonSize + 20, height: 20))
        lowSeverityLabel.text = "Low"
        lowSeverityLabel.font = labelFont
        lowSeverityLabel.textColor = textColour
        lowSeverityLabel.textAlignment = .center
        
        highSeverityLabel = UILabel(frame: CGRect(x: roadCButton.frame.origin.x + buttonSize*5/4-2, y: medSeverityLabel.frame.origin.y, width: buttonSize + 20, height: 20))
        highSeverityLabel.text = "High"
        highSeverityLabel.font = labelFont
        highSeverityLabel.textColor = textColour
        highSeverityLabel.textAlignment = .center
        
        //Details View
        detailsLabel = UILabel(frame: CGRect(x: 10, y: detailsView.frame.origin.y, width: frame.size.width-20, height: 30))
        detailsLabel.text = "Additional Details"
        detailsLabel.font = titleFont
        detailsLabel.textColor = textColour
        detailsLabel.textAlignment = .center
        
        causeLabel = UILabel(frame: CGRect(x: 10, y: detailsLabel.frame.origin.y + detailsLabel.frame.size.height, width: 92, height: 25))
        causeLabel.text = "Cause:"
        causeLabel.font = detailsFont
        causeLabel.textColor = textColour
        causeLabel.textAlignment = .right
        
        causeTextField = UITextField(frame: CGRect(x: 110, y: causeLabel.frame.origin.y, width: frame.width - 122, height: 25))
        causeTextField.backgroundColor = .white
        causeTextField.font = detailsFont
        
        otherLabel = UILabel(frame: CGRect(x: 10, y: causeLabel.frame.origin.y + 5 + causeLabel.frame.size.height, width: 100, height: 25))
        otherLabel.text = "Other Details:"
        otherLabel.font = detailsFont
        otherLabel.textColor = textColour
        otherLabel.textAlignment = .left
        
        otherTextView = UITextField(frame: CGRect(x: 110, y: otherLabel.frame.origin.y, width: frame.width - 122, height: 25))
        otherTextView.backgroundColor = .white
        otherTextView.font = detailsFont
        
        let fakeTextField = UIView(frame: CGRect(x: 110, y: otherLabel.frame.origin.y, width: frame.width - 122, height: 75))
        fakeTextField.backgroundColor = .white
        
        //Save/Cancel Button
        saveButton = UIButton(frame: CGRect(x: 132 , y: detailsView.frame.origin.y + detailsView.frame.size.height + 5, width: 92, height: 45))
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .red
        saveButton.showsTouchWhenHighlighted = true
        saveButton.titleLabel?.textColor = .white
        saveButton.titleLabel?.textAlignment = .center
        saveButton.titleLabel?.font = titleFont
        
        cancelButton = UIButton(frame: CGRect(x: 18 , y: detailsView.frame.origin.y + detailsView.frame.size.height + 5, width: 110, height: 45))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .red
        cancelButton.showsTouchWhenHighlighted = true
        cancelButton.titleLabel?.textColor = .white
        cancelButton.titleLabel?.textAlignment = .center
        cancelButton.titleLabel?.font = titleFont
        
        super.init(frame: frame)
        
        self.addSubview(alertView)
        self.addSubview(severityView)
        self.addSubview(detailsView)
        self.addSubview(fakeTextField)
        
        self.addSubview(alertLabel)
        
        self.addSubview(roadCButton)
        self.addSubview(visibilityButton)
        self.addSubview(extremeButton)
        
        self.addSubview(roadCLabel)
        self.addSubview(visibilityLabel)
        self.addSubview(extremeLabel)
        
        self.addSubview(severityLabel)
        
        self.addSubview(lowSeverityButton)
        self.addSubview(medSeverityButton)
        self.addSubview(highSeverityButton)
        
        self.addSubview(lowSeverityLabel)
        self.addSubview(medSeverityLabel)
        self.addSubview(highSeverityLabel)
        
        self.addSubview(detailsLabel)
        self.addSubview(causeLabel)
        self.addSubview(causeTextField)
        self.addSubview(otherLabel)
        self.addSubview(otherTextView)
        
        self.addSubview(saveButton)
        self.addSubview(cancelButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
