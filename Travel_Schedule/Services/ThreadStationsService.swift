import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStations = Components.Schemas.ThreadInfo

protocol ThreadStationsServiceProtocol {
    func getThreadStations(uid: String) async throws -> ThreadStations
}

final class ThreadStationsService: ThreadStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreadStations(uid: String) async throws -> ThreadStations {
        let response = try await client.getThreadInfo(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
