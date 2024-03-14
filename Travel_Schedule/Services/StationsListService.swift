import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsList = Components.Schemas.StationsListResponse

protocol StationsListServiceProtocol {
    func getStationsList(format: Operations.getStationsList.Input.Query.formatPayload?) async throws -> HTTPBody
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList(format: Operations.getStationsList.Input.Query.formatPayload? = .json) async throws -> HTTPBody {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey,
            format: format
        ))
        return try response.ok.body.html
    }
}
