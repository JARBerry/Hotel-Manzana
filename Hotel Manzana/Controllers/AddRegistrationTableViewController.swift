//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by James and Ray Berry on 13/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectedRoomTypeTableViewControllerDelegate  {
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomType?
   
    var registration: Registration? {
        
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren =
            Int(numberOfChildrenStepper.value)
        
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate:checkInDate, checkOutDate: checkOutDate, numberOfAdults:numberOfAdults, numberOfChildren:numberOfChildren, roomType:roomType, wifi: hasWifi)
        
    }
    
    

    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
   
    @IBOutlet weak var checkInDateLabel: UILabel!
    
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var checkOutDateLabel: UILabel!
    
    
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    
    
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    
    
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    
    
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        
        // define start date as current date
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
       
        

       
    }
    
    func updateDateViews() {
        
        //define check out date as current date + 1
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
        
    }
    // changes height of date picker cells when selected
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
               
                return 0.0
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                
                return 0.0
            }
        default:
            
            return 44.0
        }
    }
    
    // update number of adults and children
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
        
        
    }
    
    // update room type
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
            
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
      
        switch (indexPath.section, indexPath.row) {
   
            
            
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
        
        // check if date picker selected
        if isCheckOutDatePickerShown {
             isCheckInDatePickerShown = false
        } else if isCheckOutDatePickerShown {
            isCheckOutDatePickerShown = false
            isCheckInDatePickerShown = true
            
        } else {
            isCheckInDatePickerShown = true
        
    }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1) :
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
                
            } else {
                isCheckOutDatePickerShown = true
                
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
        
            break
            
            
    }
    }
    
    
    // seelct room type
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as?
            SelectedRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }

 
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        
    }
    
    
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
        // implement later
        
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
