//
//  EarningViewController.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 12/05/21.
//

import UIKit

class EarningViewController: BaseVC {

    enum EarningTypeSegment : Int {
        case TODAY = 1
        case WEEKLY = 2
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewSegmentContainer: UIView!
    @IBOutlet weak var btnToday: SegmentButton!
    @IBOutlet weak var btnWeekly: SegmentButton!
    @IBOutlet weak var viewLeftSeperatorLine: UIView!
    @IBOutlet weak var viewRightSeperatorLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        viewLeftSeperatorLine.cornerRadius = viewLeftSeperatorLine.frame.size.height / 2
        viewRightSeperatorLine.cornerRadius = viewRightSeperatorLine.frame.size.height / 2
        viewSegmentContainer.addBottomShadow()
    }
    
    private func setupView()
    {
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.Earning.value, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        scrollView.delegate = self
        btnToday.setTitle(ConstantString.BUTTON_TITLE_EARNING_TODAY, for: .normal)
        btnToday.tag = EarningTypeSegment.TODAY.rawValue
        
        btnWeekly.setTitle(ConstantString.BUTTON_TITLE_EARNING_WEEKLY, for: .normal)
        btnWeekly.tag = EarningTypeSegment.WEEKLY.rawValue
    
        setSegmentBasedOnIndexValue(EarningTypeSegment.TODAY.rawValue)
    }
    
    @IBAction func segmentButtonClickAction(_ sender: Any)
    {
        guard let button = sender as? UIButton else {
            return
        }
        
        setSegmentBasedOnIndexValue(button.tag)

        if (button.tag == EarningTypeSegment.TODAY.rawValue)
        {
            let xOffset = 0
            let yOffset = 0
            let customOffset = CGPoint(x: xOffset, y: yOffset)
            scrollView.setContentOffset(customOffset, animated: true)
            
        }else
        {
            let xOffset = scrollView.frame.size.width
            let yOffset = scrollView.contentOffset.y
            let customOffset = CGPoint(x: xOffset, y: yOffset)
            
            scrollView.setContentOffset(customOffset, animated: true)
        }
        
    }
    
    private func setSegmentBasedOnIndexValue(_ IndexValue : Int)
    {
        if (IndexValue == EarningTypeSegment.TODAY.rawValue)
        {
            self.btnToday.isSelected = true
            self.btnWeekly.isSelected = false
            
            self.viewLeftSeperatorLine.isHidden = false
            self.viewRightSeperatorLine.isHidden = true
            
        }else if (IndexValue == EarningTypeSegment.WEEKLY.rawValue)
        {
            self.btnToday.isSelected = false
            self.btnWeekly.isSelected = true
            
            self.viewLeftSeperatorLine.isHidden = true
            self.viewRightSeperatorLine.isHidden = false
        }
    }
}

// MARK: UIScrollViewDelegate

extension EarningViewController : UIScrollViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if decelerate == false
        {
            let currentPage = scrollView.currentPage
            // Do something with your page update
            #if DEBUG
            print("scrollViewDidEndDragging: \(currentPage)")
            #endif
            setSegmentBasedOnIndexValue(currentPage)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let currentPage = scrollView.currentPage
        // Do something with your page update
        #if DEBUG
        print("scrollViewDidEndDecelerating: \(currentPage)")
        #endif
        setSegmentBasedOnIndexValue(currentPage)
    }

}

extension UIScrollView {
   var currentPage: Int {
      return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width)+1
   }
}

