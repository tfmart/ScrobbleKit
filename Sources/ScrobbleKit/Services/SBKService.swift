//
//  SBKService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public protocol SBKService {
    associatedtype ResponseType: Decodable
    typealias CompletionType = ((ResponseType?, Error?) -> Void)?
    var sbkMethod: SBKMethod { get }
    var queries: [URLQueryItem] { get set }
    var httpMethod: SBKHttpMethod { get set }

    var apiKey: String { get set }
    var secretKey: String { get set }

    func start(_ completion: CompletionType)
    func start() async throws -> ResponseType
}

// MARK: URL builder
internal extension SBKService {
    var baseURL: String {
        "https://ws.audioscrobbler.com/2.0/"
    }
    
    var completedQueries: [URLQueryItem] {
        return [
            .init(parameter: .format, value: "json"),
            .init(parameter: .method, value: sbkMethod.rawValue),
            .init(parameter: .apiKey, value: apiKey)
        ] + queries.filter { $0.value != nil}
    }
    
    var url: URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        let queriesWithSignature = completedQueries + [.init(name: "api_sig",
                                                             value: signature)]
        urlComponents.queryItems = queriesWithSignature
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        return urlComponents.url
    }
    
    var signature: String {
        let filteredQueries = self.completedQueries
            .filter{ $0.name != "api_sig" && $0.name != "format" && $0.value != nil }
        let signature = filteredQueries
            .sorted(by: { $0.name < $1.name })
            .reduce(into: "") { result, query in
            if let value = query.value {
                result.append(query.name)
                result.append(value)
            }
        }
        let result = signature + secretKey
        return result.md5
    }
}

// MARK: Encoding/Decoding
internal extension SBKService {
    func parse(_ response: Data) throws -> ResponseType {
        do {
            let resultModel = try JSONDecoder().decode(ResponseType.self, from: response)
            return resultModel
        } catch {
            if let sbkError = parseError(response) {
                throw sbkError
            } else {
                throw error
            }
        }
    }
    
    func parse(_ response: Data) async throws -> ResponseType {
        do {
            let resultModel = try JSONDecoder().decode(ResponseType.self, from: response)
            return resultModel
        } catch {
            if let sbkError = parseError(response) {
                throw sbkError
            } else {
                throw error
            }
        }
    }
    
    func parseError(_ errorData: Data) -> SBKError? {
        do {
            let errorMessage = try JSONDecoder().decode(SBKErrorMessage.self, from: errorData)
            return errorMessage.error
        } catch {
            return nil
        }
    }
}

// MARK: Default start() implementations
public extension SBKService {
    func start(_ completion: CompletionType) {
        guard let url = url else {
            completion?(nil, SBKClientError.badURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion?(nil, error)
                return
            }
            do {
                let model = try self.parse(data)
                completion?(model, nil)
            } catch {
                completion?(nil, error)
            }
        }.resume()
    }
    
    func start() async throws -> ResponseType {
        guard let url = url else {
            throw SBKClientError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedModel = try await parse(data)
        return decodedModel
    }
}
