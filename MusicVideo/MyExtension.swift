//
//  MyExtension.swift
//  MusicVideo
//
//  Created by Marc Goldring on 2/16/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit
extension MusicVideoTVC:UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
}
