//
//  SBKService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol SBKService: Sendable {
    associatedtype ResponseType: Decodable & Sendable
    typealias CompletionType = ((ResponseType?, Error?) -> Void)?
    var sbkMethod: SBKMethod { get }
    var queries: [URLQueryItem] { get set }
    var httpMethod: SBKHttpMethod { get set }

    var apiKey: String { get set }
    var secretKey: String { get set }
    
    var completedQueries: [URLQueryItem] { get }

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
    
    var signedQueries: [URLQueryItem] {
        completedQueries + [URLQueryItem(parameter: .apiSig, value: signature)]
    }

    var encodedSignedQueries: String? {
        var urlComponents = URLComponents()
        urlComponents.queryItems = signedQueries
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        return urlComponents.percentEncodedQuery
    }

    var url: URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        if httpMethod == .get {
            urlComponents.percentEncodedQuery = encodedSignedQueries
        }
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

// MARK: Request builder
internal extension SBKService {
    func makeRequest() throws -> URLRequest {
        guard let url = url else {
            throw SBKClientError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        if httpMethod == .post {
            request.httpBody = encodedSignedQueries?.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }

        return request
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
extension SBKService {
    func start() async throws -> ResponseType {
        let request = try makeRequest()
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedModel = try await parse(data)
        return decodedModel
    }
}
