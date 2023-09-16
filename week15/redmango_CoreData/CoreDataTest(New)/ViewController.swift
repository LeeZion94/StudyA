//
//  ViewController.swift
//  CoreDataTest
//
//  Created by redmango1446 on 2023/09/02.
//

import UIKit
import CoreData

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var container: NSPersistentContainer!
    var jokeList: [JokeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        configureTableView()
        registerXib()
        getJokeList()
    }
    
    @IBAction func tapPlusButton(_ sender: UIBarButtonItem) {
        guard let secondVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {
            return
        }
        
        secondVC.saveDelegate = self
        
        present(secondVC, animated: true)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
    }
    
    private func getJokeList() {
        var newJokeList: [JokeModel] = []
        
        do {
            let joke = try self.container.viewContext.fetch(Joke.fetchRequest())
           
            joke.forEach {
                
                guard let id = $0.id else {
                    return
                }
                
                let category = $0.category!
                
                let jokeCategory: JokeModel.Category = {
                    switch category {
                    case "유행어":
                        return JokeModel.Category.유행어
                    case "아재개그":
                        return JokeModel.Category.아재개그
                    default:
                        return JokeModel.Category.유행어
                    }
                }()
                
                let jokeModel = JokeModel(content: $0.body!,
                                     category: jokeCategory,
                                     id: id)
                newJokeList.append(jokeModel)
            }
        } catch {
            
        }
        
        jokeList = newJokeList
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.bodyLabel.text = jokeList[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "아무말 대잔치"
    }
}

extension ViewController: SaveProtocol {
    func save(content: String, category: JokeModel.Category) {

        let entity = NSEntityDescription.entity(forEntityName: "Joke", in: self.container.viewContext)

        if let entity {
            let test = NSManagedObject(entity: entity, insertInto: self.container.viewContext)

            test.setValue("\(content)", forKey: "body")
            test.setValue("\(category)", forKey: "category")
            test.setValue(UUID.init(), forKey: "id")
        }
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("저장 안된듯")
        }
        
        getJokeList()
        tableView.reloadData()
    }
}
