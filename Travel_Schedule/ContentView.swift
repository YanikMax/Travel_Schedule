//
//  ContentView.swift
//  Travel_Schedule
//
//  Created by Ян Максимов on 14.03.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
//            stations()
//            allStations()
//            threadStations()
//            scheduleBetweenStations()
//            carrierInformation()
//            copyrightInformation()
//            fetchScheduleByStation()
//            nearestSettlement()
        }
    }
}

func stations() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print(stations)
            } catch {
                print("Ошибка при получении ближайших станций: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

func allStations() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = StationsListService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let allStations = try await service.getStationsList(format: .json)
                let data = try await Data(collecting: allStations, upTo: 100*1024*1024)
                print("Данные выгружены успешно: \(data.count)")
                let stationList = try JSONDecoder().decode(Components.Schemas.StationsListResponse.self, from: data)
                print("Список всех станций: \(stationList)")
            } catch {
                print("Ошибка при получении списка всех доступных станций: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

func threadStations() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadStationsService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let threadStations = try await service.getThreadStations(uid: "176YE_1_2")
                print(threadStations)
            } catch {
                print("Ошибка при получении списка станций следования: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

func scheduleBetweenStations() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ScheduleBetweenStationsService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let schedule = try await service.getScheduleBetweenStations(from: "c146", to: "c213")
                print(schedule)
            } catch {
                print("Ошибка при получении расписания рейсов между станциями: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

func carrierInformation() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierInformationService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let carrierInfo = try await service.getCarrierInformation(code: "SU", system: .iata)
                print(carrierInfo)
            } catch {
                print("Ошибка при получении информации о перевозчике: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

func copyrightInformation() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightInformationService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let copyrightInfo = try await service.getCopyrightInformation(format: "json")
                print(copyrightInfo)
            } catch {
                print("Ошибка при получении информации о копирайте: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

func fetchScheduleByStation() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ScheduleByStationService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let schedule = try await service.getScheduleByStation(
                    station: "s9600213"
                )
                print(schedule)
            } catch {
                print("Error fetching schedule by station: \(error)")
            }
        }
    } catch {
        print("Error creating client: \(error)")
    }
}

func nearestSettlement() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: "cde370fb-e370-4f60-8968-32795d3618a8"
        )
        
        Task {
            do {
                let settlement = try await service.getNearestSettlement(lat: 54.106677, lng: 39.601726)
                print(settlement)
            } catch {
                print("Ошибка при получении информации о ближайшем городе: \(error)")
            }
        }
    } catch {
        print("Ошибка при создании клиента: \(error)")
    }
}

#Preview {
    ContentView()
}
