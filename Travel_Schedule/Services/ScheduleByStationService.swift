import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleByStation = Components.Schemas.ScheduleResponse

protocol ScheduleByStationServiceProtocol {
    func getScheduleByStation(station: String) async throws -> ScheduleByStation
}

final class ScheduleByStationService: ScheduleByStationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleByStation(station: String) async throws -> ScheduleByStation {
        let response = try await client.getSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}
