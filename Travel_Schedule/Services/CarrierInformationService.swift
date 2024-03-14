import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInformation = Components.Schemas.CarrierInfo

protocol CarrierInformationServiceProtocol {
    func getCarrierInformation(code: String, system: Operations.getCarrierInfo.Input.Query.systemPayload) async throws -> CarrierInformation
}

final class CarrierInformationService: CarrierInformationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierInformation(code: String, system: Operations.getCarrierInfo.Input.Query.systemPayload) async throws -> CarrierInformation {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}
