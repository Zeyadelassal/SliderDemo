//
//  ViewController.swift
//  image slider Demo
//
//  Created by Zeyad Ellassal on 2/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    let teams = [UIImage(named: "ACMilan"),
                 UIImage(named: "AlAhly"),
                 UIImage(named: "Arsenal"),
                 UIImage(named: "Barca"),
                 UIImage(named: "Bayern"),
                 UIImage(named: "Juve"),
                 UIImage(named: "ManU"),
                 UIImage(named: "LiverPool"),
                 UIImage(named: "RM")]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderPageControl.numberOfPages = teams.count
        sliderPageControl.currentPage = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
    }
    
    @objc func slide(){
        if counter < teams.count{
            let index = IndexPath(item: counter, section: 0)
            imageSliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else{
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            imageSliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            counter = 1
        }
    }
    
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCollectionViewCell
        cell.teamLogo.image = teams[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        sliderPageControl.currentPage = Int(scrollPos)
    }

}


extension ViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

