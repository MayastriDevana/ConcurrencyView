//
//  SymbolVM.swift
//  ConcurrencyView
//
//  Created by User on 22/04/24.
//

import Foundation

class SymbolVM: ObservableObject{
    @Published var symbols: [Symbol] = Symbol.dummyData
    // MARK: -Asynchronous
    
    func downloadImageWithoutBlockingUI() async{
        let urlString = "https://res.cloudinary.com/dju4kdxnm/image/upload/v1713407504/cld-sample-3.jpg?uuid=\(UUID().uuidString)"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            print(url)
        }catch{
            print("Error downloading image: \(error)")
        }
        
    }
    
    // MARK: - Synchronous
    func downloadImageAndBlockUI(){
        let urlString = "https://res.cloudinary.com/dju4kdxnm/image/upload/v1713407504/cld-sample-3.jpg?uuid=\(UUID().uuidString)"
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().sync {
            Thread.sleep(forTimeInterval: 2)
            let output = try? Data(contentsOf: url)
            
            print(output!)
            print(url)
        }
    }
}
