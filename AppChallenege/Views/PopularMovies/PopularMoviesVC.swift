//
//  ViewController.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import UIKit

protocol PopularMoviesVCProtocol: AnyObject {
    func reloadData()
}

class PopularMoviesVC: UIViewController {
    
    // Mark:- UI
    private var viewModel: PopularMoviesViewModel!
    private let moviesTableView = UITableView()
    var isFromSearch = false
    
    private var searchBar:UISearchBar = {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 15, vertical: 0)
//        searchBar.searchBarStyle
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont(name: Fonts.interBold, size: 16)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor.black]
        )
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        return searchBar
    }()
    
    let popularLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 49))
        label.text = Strings.popularLabelText
        label.font = UIFont(name: Fonts.jomhuriaFont, size: 60)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.PopularMoviesColorFont
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.separatorStyle = .none
        view.addSubview(popularLabel)
        viewModel.getData()
        self.setupMoviesTableView()
        self.setupBackground()
        view.addSubview(searchBar)
        self.addConstraints()
        searchBar.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    // MARK:- Public Methods
    class func create() -> PopularMoviesVC {
        let popularMoviesVC: PopularMoviesVC = PopularMoviesVC()
        popularMoviesVC.viewModel = PopularMoviesViewModel(view: popularMoviesVC)
        return popularMoviesVC
    }
}

extension PopularMoviesVC {

    // Mark:- Private functions
    private func setupBackground() {
        self.view.backgroundColor = Colors.PopularMoviesBackgroundColor
    }
    
    private func setupMoviesTableView() {
        self.view.addSubview(moviesTableView)
        self.moviesTableView.register(PopularMoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // MoviesTableView Constraints
        constraints.append(moviesTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 213))
        constraints.append(moviesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(moviesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(moviesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0))
        // PopularLabel Constraints
        constraints.append(popularLabel.bottomAnchor.constraint(equalTo: self.moviesTableView.topAnchor, constant: -21))
        constraints.append(popularLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 19))
        constraints.append(popularLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 34))
        // SearchBar Constrains
        constraints.append(searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37))
        constraints.append(searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37))
//        constraints.append(searchBar.bottomAnchor.constraint(equalTo: self.popularLabel.topAnchor, constant: -20))
        constraints.append(searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 57))
        constraints.append(searchBar.heightAnchor.constraint(equalToConstant: 43))
        NSLayoutConstraint.activate(constraints)
    }
}

extension PopularMoviesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromSearch {
            
            return viewModel.getFilteredData(query: searchBar.text ?? "").count
        } else {
            print(viewModel.getDataCount(), "Number of rows")
            return viewModel.getDataCount()
        }
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 161
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PopularMoviesTableViewCell
         if isFromSearch {
             cell.configureCell(viewModel.getFilteredData(query: searchBar.text ?? "")[indexPath.row])
//             cell.configureCell(viewModel.getFilteredData(text: searchBar.text ?? "")[indexPath.row])
         } else {
             cell.configureCell(viewModel.getData(for: indexPath.row))
         }
         cell.userScoreLabel.text = "score"
         var genreData: [GenreData] = []
         if let genresID = viewModel.getData(for: indexPath.row).genre_ids {
             for id in genresID {
                 if viewModel.getGenresData().count > 0 {
                     for i in 0...self.viewModel.getGenresData().count - 1 {
                         if id == self.viewModel.getGenresData()[i].id {
                             genreData.append(self.viewModel.getGenresData()[i])
                         }
                     }
                 }
              
             }
             cell.genre = genreData 
         }
         cell.genreCollectionView.reloadData()
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsVC.create(movie: viewModel.getData(for: indexPath.row))
         navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PopularMoviesVC: PopularMoviesVCProtocol {
    func reloadData() {
        self.moviesTableView.reloadData()
    }
    
    
}

extension PopularMoviesVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        if text.isEmpty {
            isFromSearch = false
            viewModel.getData()
        } else {
            isFromSearch = true
            
            viewModel.getSearchData(text: searchBar.text ?? "")
        }
        
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFromSearch = false
        searchBar.resignFirstResponder()
        viewModel.getData()
        searchBar.text = ""
        self.moviesTableView.reloadData()
        
    }
}

