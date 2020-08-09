import struct Foundation.URL
import Moya
import Foundation

public protocol SugarTargetType: TargetType {
    typealias RoutePath = Route
    
    var url: URL { get }
    var route: Route { get }
    var parameters: Parameters? { get }
    var httpHeaderFields: [Header] { get }

}

public extension SugarTargetType {
    
    // MARK: - Computed Properties
    var defaultURL: URL {
        return self.path.isEmpty ? self.baseURL : self.baseURL.appendingPathComponent(self.path)
    }
    
    // MARK: - SugarTargetType
    var httpHeaderFields: [Header] {
        return []
    }
    
    var url: URL {
        return self.defaultURL
    }
    
    // MARK: - TargetType
    var path: String {
        return self.route.path
    }
    
    var method: Moya.Method {
        return self.route.method
    }
    
    var task: Task {
        guard let parameters = self.parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters.values, encoding: parameters.encoding)
    }
    
    var headers: [String : String]? {
        var headers = [String: String]()
        
        httpHeaderFields.forEach { header in
            headers[header.key] = header.value
        }
        
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
