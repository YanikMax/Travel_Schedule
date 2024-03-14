import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightInformation = Components.Schemas.CopyrightInfo

protocol CopyrightInformationServiceProtocol {
    func getCopyrightInformation(format: String) async throws -> CopyrightInformation
}

final class CopyrightInformationService: CopyrightInformationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyrightInformation(format: String) async throws -> CopyrightInformation {
        let response = try await client.getCopyrightInfo(query: .init(
            apikey: apikey,
            format: format
        ))
        return try response.ok.body.json
    }
}
