//
//  FileHelper.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

class FileService {

    // MARK: - Helper method to get path of the file
    func getFilePath(_ fileName: String) -> URL? {
        guard  let documentUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return  nil
        }
        let destinationUrl = documentUrls.appendingPathComponent(fileName)
        return destinationUrl
    }

    // MARK: - Helper method to check if file exists at path
    func checkFileAtPath(path: String) -> Bool {
        return FileManager().fileExists(atPath: path) ? true : false
    }

    // MARK: - Helper method to save file at path
    func saveFileAtPath(data: Data, path: URL) throws {
        try data.write(to: path)
    }

    // MARK: - Helper method to read file content from the given path
    func readFileAtPath(path: String) throws -> Data {

        return (try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped))

    }
}
