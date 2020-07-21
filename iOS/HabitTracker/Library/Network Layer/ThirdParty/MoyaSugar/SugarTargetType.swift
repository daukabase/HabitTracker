import struct Foundation.URL
import Moya
import Foundation

public protocol SugarTargetType: TargetType {
    typealias RoutePath = Route
    
    var url: URL { get }
    var route: Route { get }
    var parameters: Parameters? { get }

}

public extension SugarTargetType {
    
    var baseURL: URL {
        return Config.baseUrl
    }
    
    var defaultURL: URL {
        return self.path.isEmpty ? self.baseURL : self.baseURL.appendingPathComponent(self.path)
    }
    
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
    
}
