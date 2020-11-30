//
//  DetailViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import UIKit
import RxSwift


class DetailViewController: BaseViewController {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelGendre: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelProduction: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    var disposeBag: DisposeBag!
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setupBinding()
        setupView()
    }
    override func viewDidLayoutSubviews() {
        imageWidth.constant = view.frame.width / 2.5
    }
    
    func setupView() {
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
    }
    
    func setupBinding() {
        viewModel.movie.subscribe(onNext: { [weak self] (movie) in
            self?.showMovieDetail(movie: movie)
        }).disposed(by: disposeBag)
        viewModel.isLoading.subscribe(onNext: { [weak self] isShow in
            if isShow {
                self?.showLoadingDialog()
            } else {
                self?.hideLoadingDialog()
            }
        }).disposed(by: disposeBag)
        viewModel.stateErrorView.subscribe(onNext: {[weak self] error in
            self?.hideLoadingDialog {
                self?.errorAlert(message: error)
            }
        }).disposed(by: disposeBag)
    }
    
    func showMovieDetail(movie: MovieDetailModel) {
        viewMain.isHidden = false
        imageView.setImage(from: movie.posterPath ?? "")
        labelTitle.text = movie.title
        labelYear.text = "(\(movie.year ?? ""))"
        labelReleaseDate.text = movie.releaseDate
        labelGendre.text = movie.genres?.joined(separator: ", ") ?? "-"
        labelLanguage.text = movie.language?.joined(separator: ", ") ?? "-"
        labelProduction.text = movie.productions?.joined(separator: ", ") ?? "-"
        labelOverview.text = movie.overview
    }

}
