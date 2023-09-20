//
//  ULTestViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 26/07/23.
//

import UIKit

class ULTestViewController: UIViewController {
    // Create a variable to hold the DetailCourseViewModel instance
    // var detailCourseViewModel: DetailCourseViewModel!
    
    // Add all the required UI elements as properties
    private var scrollView: UIScrollView!
    private var appBar: UIView!
    private var collapsingToolbar: UIView!
    private var imageView: UIImageView!
    private var toolbar: UIToolbar!
    private var titleText: UILabel!
    private var descriptionText: UILabel!
    // Add other UI elements as needed.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white

        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        appBar = UIView()
        appBar.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(appBar)
        
        collapsingToolbar = UIView()
        collapsingToolbar.translatesAutoresizingMaskIntoConstraints = false
        appBar.addSubview(collapsingToolbar)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        collapsingToolbar.addSubview(imageView)
        
        toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        collapsingToolbar.addSubview(toolbar)
        
        titleText = UILabel()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        collapsingToolbar.addSubview(titleText)
        
        descriptionText = UILabel()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        collapsingToolbar.addSubview(descriptionText)
        
        // Add other UI elements as needed.
        
        // Setup constraints for the UI elements
        
        // Constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            // Constraints for appBar
            
            appBar.topAnchor.constraint(equalTo: scrollView.topAnchor),
            appBar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            appBar.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            appBar.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            appBar.heightAnchor.constraint(equalToConstant: 200), // Set the height as needed.
            
            
            // Constraints for collapsingToolbar
            
            collapsingToolbar.topAnchor.constraint(equalTo: appBar.topAnchor),
            collapsingToolbar.leadingAnchor.constraint(equalTo: appBar.leadingAnchor),
            collapsingToolbar.trailingAnchor.constraint(equalTo: appBar.trailingAnchor),
            collapsingToolbar.bottomAnchor.constraint(equalTo: appBar.bottomAnchor),
            
            
            // Constraints for imageView
            
            imageView.topAnchor.constraint(equalTo: collapsingToolbar.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: collapsingToolbar.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: collapsingToolbar.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: collapsingToolbar.bottomAnchor),
            
            
            // Constraints for toolbar
            
            toolbar.topAnchor.constraint(equalTo: imageView.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            
            // Constraints for titleText
            
            titleText.topAnchor.constraint(equalTo: collapsingToolbar.topAnchor, constant: 10),
            titleText.leadingAnchor.constraint(equalTo: collapsingToolbar.leadingAnchor, constant: 10),
            titleText.trailingAnchor.constraint(equalTo: collapsingToolbar.trailingAnchor, constant: -10),
            // Add height constraint if needed: titleText.heightAnchor.constraint(equalToConstant: 30)
            
            
            // Constraints for descriptionText
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            descriptionText.leadingAnchor.constraint(equalTo: collapsingToolbar.leadingAnchor, constant: 10),
            descriptionText.trailingAnchor.constraint(equalTo: collapsingToolbar.trailingAnchor, constant: -10),
            // Add height constraint if needed: descriptionText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupData() {
        // Set up data for the UI elements from the detailCourseViewModel
        titleText.text = "nombre"// detailCourseViewModel.courseTitle
        descriptionText.text = "description"// detailCourseViewModel.courseDescription
        // Set other data as needed.
    }
    
    // Add other methods and event handlers as required.
}
