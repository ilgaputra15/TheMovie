//
//  DetailViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import UIKit
import RxSwift
import Core

public class DetailViewController: BaseViewController {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelGendre: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelProduction: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    var disposeBag: DisposeBag!
    var viewModel: DetailViewModel!
    
    init() {
        super.init(nibName: "DetailViewController", bundle: Bundle(for: DetailViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setupBinding()
        viewModel.getDetail()
    }
    
    func setButtonBar(isFavorite: Bool) {
        let image = isFavorite ? UIImage(named: "Favorite Active") : UIImage(named: "Favorite Unactive")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(updateButton)
        )
    }
    
    @objc func updateButton() {
        viewModel.saveFavorite.accept(())
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
        viewModel.isFavorite.subscribe { (isFavorite) in
            self.setButtonBar(isFavorite: isFavorite)
        }.disposed(by: disposeBag)

    }
    
    func showMovieDetail(movie: MovieDetailModel) {
        viewMain.isHidden = false
        imageView.setImage(from: movie.posterPath ?? "")
        labelTitle.text = movie.title
        labelYear.text = "(\(movie.year ?? ""))"
        labelReleaseDate.text = movie.releaseDate
        labelGendre.text = movie.genres.count > 0 ? movie.genres.joined(separator: ", ") : "-"
        labelLanguage.text = movie.language.count > 0 ? movie.language.joined(separator: ", ") : "-"
        labelProduction.text = movie.productions.count > 0 ? movie.productions.joined(separator: ", ") : "-"
        labelOverview.text = movie.overview
    }

}
