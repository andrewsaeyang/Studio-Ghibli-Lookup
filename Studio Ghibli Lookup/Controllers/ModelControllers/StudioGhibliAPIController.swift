//
//  ModelControllers.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/1/21.
//

import Foundation

class StudioGhibliAPIController{
    
    // Studio Ghibli API
    static let baseURL = URL(string: "https://ghibliapi.herokuapp.com")
    static let filmComponent = "films"
    static let peopleComponent = "people"
    static let locationComponent = "locations"
    static let speciesComponent = "species"
    static let vehiclesComponent = "vehicles"
    
} // End of class


//Main fetch functions
extension StudioGhibliAPIController{
    
    static func fetchFilms(completion: @escaping(Result<[Film], NetworkError>) -> Void){
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(filmComponent)
        
        print(finalURL)
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let films = try JSONDecoder().decode([Film].self, from: data)
                completion(.success(films))
            }catch{
                completion(.failure(.unableToDecode))
            }
        }
        task.resume()
    }
    
    static func fetchPeople(completion: @escaping(Result<[Person], NetworkError>) -> Void){
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(peopleComponent)
        
        print(finalURL)
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let people = try JSONDecoder().decode([Person].self, from: data)
                completion(.success(people))
            }catch{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.unableToDecode))
            }
        }
        task.resume()
    }
    
    static func fetchLocations(completion: @escaping(Result<[Location], NetworkError>) -> Void){
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(locationComponent)
        
        print(finalURL)
        
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(.thrownError(error))))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let locations = try JSONDecoder().decode([Location].self, from: data)
                completion(.success(locations))
                
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }
        task.resume()
    }
    
    static func fetchSpecies(completion: @escaping(Result<[Species], NetworkError>) -> Void){
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(speciesComponent)
        
        print(finalURL)
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, respone, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(.thrownError(error))))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let species = try JSONDecoder().decode([Species].self, from: data)
                completion(.success(species))
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }
        task.resume()
    }
    
    static func fetchVehicles(completion: @escaping(Result<[Vehicle],NetworkError>) -> Void){
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(vehiclesComponent)
        
        print(finalURL)
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(.thrownError(error))))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                completion(.success(vehicles))
            } catch {
                return completion(.failure(.unableToDecode))
            }
            
        }
        task.resume()
    }
    
} // End of Extension
extension StudioGhibliAPIController{
    /*
     This extension holds all functions to filter out all repsective objects within a film to display on the sub menu after you click into a film
     */
    static func filterPeople(in filmID: String, toFilter: [Person]) -> [Person] {
        var retval: [Person] = []
        
        for item in toFilter{
            for film in item.films{
                do{
                    let filmToCompare = try String(contentsOf: film)
                    if filmToCompare.contains(filmID){
                        retval.append(item)
                    }
                } catch{
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        print("we found \(retval.count) people")
        return retval
        
    }
    
    static func filterLocations(in filmID: String, toFilter: [Location]) -> [Location] {
        var retval: [Location] = []
            
        for item in toFilter{
            for film in item.locationAppearance{
                
                do{
                    let filmToCompare = try String(contentsOf: film)
                    if filmToCompare.contains(filmID){
                        retval.append(item)
                    }
                } catch{
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        print("we found \(retval.count) locations")
        return retval
        
    }
    
    static func filterSpecies(in filmID: String, toFilter: [Species]) -> [Species] {
        var retval: [Species] = []
        
        for item in toFilter{
            for film in item.films{
                
                do{
                    let filmToCompare = try String(contentsOf: film)
                    if filmToCompare.contains(filmID){
                        retval.append(item)
                    }
                } catch{
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        print("we found \(retval.count) species")
        return retval
        
    }
    
    static func filterVehicles(in filmID: String, toFilter: [Vehicle]) -> [Vehicle] {
        var retval: [Vehicle] = []
        
        for item in toFilter{
            for film in item.vehicleAppearance{
                
                do{
                    let filmToCompare = try String(contentsOf: film)
                    if filmToCompare.contains(filmID){
                        retval.append(item)
                    }
                } catch{
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        print("we found \(retval.count) vehicles")
        return retval
        
    }
    
}
