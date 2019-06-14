//
//  StarwarsFilmCell.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

struct StarwarsFilmCellViewModel {
    let film: StarwarsFilmModel?
    
    var title: String {
        return "\(film?.episode_id ?? 0) \(film?.title ?? "") - \(film?.director ?? "")"
    }
}

final class StarwarsFilmCell: UITableViewCell {
    func configure(film: StarwarsFilmModel?) {
        let viewModel = StarwarsFilmCellViewModel(film: film)
        textLabel?.text = viewModel.title
    }
}
