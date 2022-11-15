//
//  FeedViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//
import SnapKit
import UIKit


class FeedViewController: UIViewController {
    
    var residentsArray = [String]()
    
    private lazy var textLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var planetLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var setIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    } ()
    
    private lazy var setPlanetIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    } ()
    
    private lazy var residentsTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Table")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.setIndicator.startAnimating()
        self.setPlanetIndicator.startAnimating()
        setNetwork()
        setLayer()
    }
    
    func setLayer() {
        self.view.addSubview(textLabel)
        self.view.addSubview(planetLabel)
        self.view.addSubview(setIndicator)
        self.view.addSubview(setPlanetIndicator)
        self.view.addSubview(residentsTable)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        setIndicator.snp.makeConstraints { make in
            make.center.equalTo(textLabel.snp.center)
            make.height.width.equalTo(50)
        }
        
        planetLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        setPlanetIndicator.snp.makeConstraints { make in
            make.center.equalTo(planetLabel.snp.center)
            make.height.width.equalTo(50)
        }
        
        residentsTable.snp.makeConstraints { make in
            make.top.equalTo(planetLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//: MARK: TABLE DELEGATE

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Residents of Tatooine"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table", for: indexPath)
        var config = cell.defaultContentConfiguration()
        let urlString  =  residentsArray[indexPath.row]
        
        residentNetwork(for: urlString) { requestString in
            DispatchQueue.main.async {
                if let requestString {
                    config.text = requestString
                    cell.contentConfiguration = config
                }
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//: MARK: NETWORK
extension FeedViewController {
    
    func setNetwork () {
        requestOne(for: NetworkConfiguration.urlOne.rawValue) { requestString in
            DispatchQueue.main.async {
                if let requestString {
                    self.setIndicator.stopAnimating()
                    self.textLabel.text = "TITLE : \(requestString)"
                }
            }
        }
        
        
        planetNetwork(for: NetworkConfiguration.urlTwo.rawValue) { requestString in
            DispatchQueue.main.async {
                self.residentsTable.reloadData()
                self.setPlanetIndicator.stopAnimating()
                if let requestString {
                    self.planetLabel.text = "ORBITAL PERIOD: \(requestString)" }
            }
        }
    }
    
    
    func planetNetwork(for urlString: String, completion: ((_ requestString: String?)->())? ) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            
            if let error {
                print("Error: \(error.localizedDescription)")
                completion?(nil)
            }
            
            
            if (response as? HTTPURLResponse)?.statusCode  != 200 {
                print(MyError.responseError)
                completion?(nil)
            }
            
            
            guard let data else  {
                print(MyError.dataError)
                completion?(nil)
                return
            }
            
            
            do {
                let answer = try JSONDecoder().decode(PlanetAnswer.self, from: data)
                let residents = answer.residents
                for url in residents {
                    self.residentsArray.append(url)
                }
                completion?(answer.orbital_period )
            }
            catch {
                print("Error Do-catch block")
            }
        }
        task.resume()
    }
}
