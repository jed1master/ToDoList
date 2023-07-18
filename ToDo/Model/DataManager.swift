//
//  DataManager.swift
//  ToDo
//
//  Created by Александр Корепанов on 12.07.2023.
//

import UIKit

class DataManager {
    
    //    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    //
    //    lazy var folderUrl = urls.first
    //
    //    lazy var storeURL = folderUrl?.appending(path: "store.json")
    //
    //    func saveData(todoListArray: [ToDoItem]) {
    //        if let path = storeURL?.absoluteString {
    //            FileManager.default.createFile(atPath: path, contents: myData)
    //        }
    //    }
    ////
    ////    func loadData {
    ////        let data = try? Data(contentsOf: storeURL)
    ////    }
    //
    //    func saveData(myArray: [ToDoItem]) {
    //
    //        guard let documentDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
    //        let fileUrl = documentDirectoryUrl.appendingPathComponent("store.json")
    //
    //        do {
    //            let data = try JSONSerialization.data(withJSONObject: myArray, options: [])
    //            try data.write(to: fileUrl, options: [])
    //        } catch {
    //            print(error)
    //        }
    //    }
    //
    //    func loadData() {
    //
    //        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    //        let fileUrl = documentsDirectoryUrl.appendingPathComponent("store.json")
    //
    //        do {
    //            let data = try Data(contentsOf: fileUrl, options: [])
    //            guard let myArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: [String: String]]] else { return }
    //            print(myArray)
    //        } catch {
    //            print(error)
    //        }
    //    }
    
    func saveData(myArray: [ToDoItem]) {
        
        let pathDirectory = getDocumentsDirectory()
        
        try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        
        let filePath = pathDirectory.appendingPathComponent("store.json")
        print(filePath)
        
        do {
            let json = try JSONEncoder().encode(myArray)
            try json.write(to: filePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    
    func loadData() -> [ToDoItem] {
        var todoItemsFromJsom = [ToDoItem]()
        
        let pathDirectory = getDocumentsDirectory()
        
        let filePath = pathDirectory.appendingPathComponent("store.json")
        
        print(filePath)
        
        if let data = try? Data(contentsOf: filePath) {
            
            let decoder = JSONDecoder()
            
            do {
                let todoItems = try decoder.decode([ToDoItem].self, from: data)
                todoItemsFromJsom = todoItems
            } catch {
                print("error:", error)
            }
        }
        return todoItemsFromJsom
    }

}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


