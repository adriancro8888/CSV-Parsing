//
//  API.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
import CSV

enum APIError: Error, LocalizedError {
    case invalidResponse
    case notFound
    case noItems
    
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("Requested item was not found", comment: "My error")
        case .invalidResponse:
            return NSLocalizedString("Recevied an Invalid response", comment: "my error")
        case .noItems:
            return NSLocalizedString("No Elements found.", comment: "my error")
        }
    }
}
class API {
    
    // MARK: - Private
    private let csvCache = Cache()
    private let network: Network
    private let fileService: FileService
    
    // MARK: - Lifecycle
    init(network: Network, fileService: FileService) {
        self.network = network
        self.fileService = fileService
    }
    
    // MARK: - Public
    func processSuccessBlock(_ data: Data) throws  {
        if let filePath = self.fileService.getFilePath("data.csv") {
            try? self.fileService.saveFileAtPath(data: data, path: filePath)
        }
        guard  let content =  String(bytes: data, encoding: .utf8) else {
            throw APIError.invalidResponse
        }
        try processCSV(content)
    }
    func  processCSV(_ content: String) throws {
        let csv = try CSVReader(string: content, hasHeaderRow: true)
        let items =  Array(csv.flatMap(Element.init))
        csvCache.setObjects(objects: items)
        
    }
    func getItems(success: @escaping ([Element]) -> Void, failure: @escaping (Error) -> Void) {
        let request = NetworkRequest(
            method: .get,
            url: "https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"
        )
        _ = network.makeRequest(request: request, callback: { [weak self] result in
            switch result {
            case .success(let data):
                guard let strongSelf = self else { return }
                do {
                    try strongSelf.processSuccessBlock(data)
                    DispatchQueue.main.async {
                        strongSelf.csvCache.getObjects({ (items: [Element]) in
                            success(items)
                        })
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self?.csvCache.getObjects({ (items: [Element]) in
                        items.count > 0 ? success(items) : failure(error)
                    })
                }
            }
        })
    }
}
