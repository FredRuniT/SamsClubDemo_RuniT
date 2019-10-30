//
//  DPVCViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/29/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

class ProductDetailsContentViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    let dataSource = ["V1", "V2", "V3","V4"]
    var customPageViewController: CustomPageViewController!
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageViewController()
    }
    
    
    func configurePageViewController() {
        
        guard let pageViewController = storyboard?.instantiateViewController(identifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        contentView.addSubview(pageViewController.view)
        contentView.fillSuperview()
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    
    func detailViewControllerAt(index: Int) -> ProductDetailsDataModel? {
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(identifier: String(describing: ProductDetailsDataModel.self)) as? ProductDetailsDataModel else {
            return nil
        }
        
        dataViewController.pageIndex = index
       // dataViewController.displayText = dataSource[index]
        
        return dataViewController
    }
}

// MARK: - UIPageViewController DataSoure & Delegate

extension ProductDetailsContentViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? ProductDetailsDataModel
        
        guard var currentIndex = dataViewController?.pageIndex else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil //Don't go backwards.
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        let dataViewController = viewController as? ProductDetailsDataModel
        
        guard var currentIndex = dataViewController?.pageIndex else {
            return nil
        }
        
        if currentIndex == dataSource.count {
            return nil //Dont overstep the array.
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
}
