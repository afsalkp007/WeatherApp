//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//


import Foundation

struct WeatherData : Codable {
    
    struct WindInformation : Codable {
        let speed : Double?
        let deg : Int?
        
        enum CodingKeys: String, CodingKey {
            case speed = "speed"
            case deg = "deg"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            speed = try values.decodeIfPresent(Double.self, forKey: .speed)
            deg = try values.decodeIfPresent(Int.self, forKey: .deg)
        }
        
    }
    
    
    struct WeatherCondition : Codable {
        let identifier : Int?
        let main : String?
        let description : String?
        let icon : String?
        
        enum CodingKeys: String, CodingKey {
            
            case identifier = "id"
            case main = "main"
            case description = "description"
            case icon = "icon"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            identifier = try values.decodeIfPresent(Int.self, forKey: .identifier)
            main = try values.decodeIfPresent(String.self, forKey: .main)
            description = try values.decodeIfPresent(String.self, forKey: .description)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
        }
        
    }
    
    struct DayInformation : Codable {
        let type : Int?
        let id : Int?
        let country : String?
        let sunrise : Double?
        let sunset : Double?
        
        enum CodingKeys: String, CodingKey {
            
            case type = "type"
            case id = "id"
            case country = "country"
            case sunrise = "sunrise"
            case sunset = "sunset"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            type = try values.decodeIfPresent(Int.self, forKey: .type)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            country = try values.decodeIfPresent(String.self, forKey: .country)
            sunrise = try values.decodeIfPresent(Double.self, forKey: .sunrise)
            sunset = try values.decodeIfPresent(Double.self, forKey: .sunset)
        }
        
    }
    
    
    struct AtmosphericInformation : Codable {
        let temperatureKelvin : Double?
        let pressurePsi : Int?
        let humidity : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case temperatureKelvin = "temp"
            case pressurePsi = "pressure"
            case humidity = "humidity"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            temperatureKelvin = try values.decodeIfPresent(Double.self, forKey: .temperatureKelvin)
            pressurePsi = try values.decodeIfPresent(Int.self, forKey: .pressurePsi)
            humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        }
        
    }
    
    
    struct Coordinates : Codable {
        let longitude : Double?
        let latitude : Double?
        
        enum CodingKeys: String, CodingKey {
            
            case longitude = "lon"
            case latitude = "lat"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
            latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        }
        
    }
    
    struct Clouds : Codable {
        let coverage : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case coverage = "all"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            coverage = try values.decodeIfPresent(Int.self, forKey: .coverage)
        }
        
    }
    
    var coordinates : Coordinates
    var weatherCondition : [WeatherCondition]
    var atmosphericInformation : AtmosphericInformation
    var visibility : Int
    var windInformation : WindInformation
    var cloudCoverage : Clouds
    var dayInformation : DayInformation
    var timezone : Int
    var cityID : Int
    var cityName : String
    var cod : Int
    
    enum CodingKeys: String, CodingKey {
        
        case coordinates = "coord"
        case weatherCondition = "weather"
        case atmosphericInformation = "main"
        case visibility = "visibility"
        case windInformation = "wind"
        case cloudCoverage = "clouds"
        case dayInformation = "sys"
        case timezone = "timezone"
        case cityID = "id"
        case cityName = "name"
        case cod = "cod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try values.decode(Coordinates.self, forKey: .coordinates)
        weatherCondition = try values.decode([WeatherCondition].self, forKey: .weatherCondition)
        atmosphericInformation = try values.decode(AtmosphericInformation.self, forKey: .atmosphericInformation)
        visibility = try values.decode(Int.self, forKey: .visibility)
        windInformation = try values.decode(WindInformation.self, forKey: .windInformation)
        cloudCoverage = try values.decode(Clouds.self, forKey: .cloudCoverage)
        dayInformation = try values.decode(DayInformation.self, forKey: .dayInformation)
        timezone = try values.decode(Int.self, forKey: .timezone)
        cityID = try values.decode(Int.self, forKey: .cityID)
        cityName = try values.decode(String.self, forKey: .cityName)
        cod = try values.decode(Int.self, forKey: .cod)
    }
    
    static func make(data: Data) -> WeatherData? {
        return try? JSONDecoder().decode(WeatherData.self, from: data)
    }
    
}
