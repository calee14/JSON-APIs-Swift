//
//  Challenges.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/26/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

internal func exerciseOne() {
    // This would normally be network calls that return `NSData`. We'll show you how to do those soon!
    // In this case, we are using a local JSON file.
    guard let jsonURL = Bundle.main.url(forResource: "Random-User", withExtension: "json") else {
        print("Could not find Random-User.json!")
        return
    }
    let jsonData = try! Data(contentsOf: jsonURL)


    // Enter SwiftyJSON!
    // userData now contains a JSON object representing all the data in the JSON file.
    // This JSON file contains the same data as the tutorial example.
    let userData = try! JSON(data: jsonData)
    let user = userData["results"][0]
    // Alright, now we have a JSON object from SwiftyJSON containing the user data!
    // Let's save the user's first name to a constant!
    // User's name
    let username = user["name"]
    let title = username["title"].stringValue
    let firstName = username["first"].stringValue
    let lastName = username["last"].stringValue

    // Location
    let location = user["location"]
    let streetName = location["street"].stringValue
    let city = location["city"].stringValue
    let state = location["state"].stringValue
    let postCode = location["postcode"].stringValue

    // Email
    let email = user["email"].stringValue

    // Phone Number
    let phoneNumber = user["phone"].stringValue

    //
    // Do you see what we did there? We navigated down the JSON heirarchy, asked for "results",
    // then the first dictionary value of that array, then the dictionary stored in "name",
    // then the value stored in "first". We  then told it that we wanted the value as a string.

    /*

     Now it's your turn to get the rest of the values needed to print the following:

     "<first name> <last name> lives at <street name> in <city>, <state>, <post code>.
     If you want to contact <title>. <last name>, you can email <email address> or
     call at <cell phone number>."

     */

    let sentence = "\(firstName) \(lastName) lives at \(streetName) in \(city), \(state), \(postCode). If you want to contact \(title). \(lastName), you can email \(email) or call at \(phoneNumber)."
    print(sentence)




}

internal func exerciseTwo() {
    // This would normally be network calls that return `NSData`. We'll show you how to do those soon!
    // In this case, we are using a local JSON file.
    guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
        print("Could not find Random-User.json!")
        return
    }
    let jsonData = try! Data(contentsOf: jsonURL)


    // Enter SwiftyJSON!
    // moviesData now contains a JSON object representing all the data in the JSON file.
    // This JSON file contains the same data as the tutorial example.
    let moviesData = try! JSON(data: jsonData)

    // We save the value for ["feed"]["entry"][0] to topMovieData to pull out just the first movie's data
    let topMovieData = moviesData["feed"]["entry"][0]
    let topMovie = Movie(json: topMovieData)

    // Uncomment this print statement when you are ready to check your code!

    print("The top movie is \(topMovie.name) by \(topMovie.rightsOwner). It costs $\(topMovie.price) and was released on \(topMovie.releaseDate). You can view it on iTunes here: \(topMovie.link)")
}

internal func exerciseThree() {
    // This would normally be network calls that return `NSData`. We'll show you how to do those soon!
    // In this case, we are using a local JSON file.
    guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
        print("Could not find iTunes-Movies.json!")
        return
    }
    let jsonData = try! Data(contentsOf: jsonURL)

    // Enter SwiftyJSON!
    // moviesData now contains a JSON object representing all the data in the JSON file.
    // This JSON file contains the same data as the tutorial example.
    let moviesData = try! JSON(data: jsonData)

    // We've done you the favor of grabbing an array of JSON objects representing each movie
    let allMoviesData = moviesData["feed"]["entry"].arrayValue

    /*

     Figure out a way to turn the allMoviesData array into Movie structs!

     */
    var allMovies: [Movie] = []

    for jsonObject in allMoviesData {
        allMovies.append(Movie(json: jsonObject))
    }

    func printMovieNames(movies: [Movie]) {
        for movie in movies {
            print(movie.name)
        }
    }

    /*

     Uncomment the below print statement and then print out the names of the two Disney
     movies in allMovies. A movie is considered to be a "Disney movie" if `rightsOwner`
     contains the `String` "Disney". Iterate over all the values in `allMovies` to check!

     */
    print("The following movies are Disney movies:")

    let disneyMovies = allMovies.filter({
        if $0.rightsOwner.lowercased().range(of:"disney") != nil {
            return true
        }
        return false
    })

    printMovieNames(movies: disneyMovies)

    /*

     Uncomment the below print statement and then print out the name and price of each
     movie that costs less than $15. Iterate over all the values in `allMovies` to check!

     */
    print("The following movies are cost less than $15:")

    let cheapMovies = allMovies.filter({
        if $0.price < 15.0 {
            return true
        }
        return false
     })

    printMovieNames(movies: cheapMovies)



    /*

     Uncomment the below print statement and then print out the name and release date of
     each movie released in 2016. Iterate over all the values in `allMovies` to check!

     */
    print("The following movies were released in 2016:")

    let moviesBefore2016 = allMovies.filter { $0.releaseDate.lowercased().range(of:"2016") != nil }

    printMovieNames(movies: moviesBefore2016)


}
