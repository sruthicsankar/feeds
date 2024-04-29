//
//  ViewController.swift
//  Feeds
//
//  Created by Sruthi CS on 29/04/24.
//

import UIKit


class Post: Codable {
    let id: Int
    let title: String
    let body: String
    
    
    // Function to simulate heavy computation
    func performHeavyComputation() {
        
        let startTime = Date()
        // Log time taken
        let endTime = Date()
        let timeTaken = endTime.timeIntervalSince(startTime)
        print("Heavy computation time for post \(id): \(timeTaken) seconds")
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
       
       var posts: [Post] = []
       var currentPage = 1
       let pageSize = 10
       
       override func viewDidLoad() {
           super.viewDidLoad()
           fetchPosts()
           registerTableViewCells()
       }
    
    private func registerTableViewCells() {
        let cell = UINib(nibName: "TableViewCell",
                               bundle: nil)
        self.tableView.register(cell,
                                forCellReuseIdentifier: "TableViewCell")
    }
       
       func fetchPosts() {
           guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)") else {
               return
           }
           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else { return }
               do {
                   let fetchedPosts = try JSONDecoder().decode([Post].self, from: data)
                   DispatchQueue.main.async {
                       self.posts.append(contentsOf: fetchedPosts)
                       self.tableView.reloadData()
                   }
               } catch let error {
                   print("Error decoding JSON: \(error)")
               }
           }.resume()
       }
   }

   extension ViewController: UITableViewDataSource, UITableViewDelegate {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return posts.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
           let post = posts[indexPath.row]
           cell.nameLbl.text = "ID: \(post.id)"
           cell.detailLbl.text = post.title
           return cell
       }
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
           if indexPath.row == lastRowIndex {
               currentPage += 1
               fetchPosts()
           }
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let post = posts[indexPath.row]
           post.performHeavyComputation()
           
           // Navigate to detailed view passing necessary data
           
           let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
           detailVC.datas = post.body
           self.navigationController?.pushViewController(detailVC, animated: true)

       }
   }

