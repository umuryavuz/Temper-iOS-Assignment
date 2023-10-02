//
//  JobDTO.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation

struct JobDTO: Codable {
    
    struct ProjectDTO: Codable {
        let client: ClientDTO
    }
    
    struct ClientDTO: Codable {
        struct LinksDTO: Codable {
            let heroImage: String
            let thumbImage: String
            
            private enum CodingKeys: String, CodingKey {
                case heroImage = "hero_image"
                case thumbImage = "thumb_image"
            }
        }
        let name: String
        let links: LinksDTO
    }
    
    struct CategoryDTO: Codable {
        struct NameTranslationDTO: Codable {
            let en_GB: String?
        }
        let nameTranslation: NameTranslationDTO
        
        private enum CodingKeys: String, CodingKey {
            case nameTranslation = "name_translation"
        }
    }
    
    struct AddressDTO: Codable {
        
        struct CoordinatesDTO: Codable {
            let latitude: Double
            let longitude: Double
            
            private enum CodingKeys: String, CodingKey {
                case latitude = "lat"
                case longitude = "lon"
            }
        }
        
        let coordinates: CoordinatesDTO
               
        private enum CodingKeys: String, CodingKey {
            case coordinates = "geo"
        }
    }
    
    let id: String
    let title: String
    let project: ProjectDTO
    let category: CategoryDTO
    let address: AddressDTO
    
    private enum CodingKeys: String, CodingKey {
        case id, title, project, category
        case address = "report_at_address"
    }
    
}
