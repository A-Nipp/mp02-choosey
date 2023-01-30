# Choosey

## Goal

This project aims to do two things:

1. Give you a first exposure to working on a real app in Xcode
2. Give you a chance to apply your new knowledge of the basic principles of Swift

The repository already contains a fully-featured app, **Choosey**, that helps users decide where to eat. As a part of today's meeting, you will be adding a couple of features to help make the user-experience *great*.

This is what we'll be working towards:

<img src="Screenshots/choosey-demo.gif" alt="Choosey Demo" width="250"/>

## Installation

Here are the steps to get the starter repo for this project onto your machine and opened with Xcode.

1. Clone this repository onto your computer. I recommend that you create a new directory specifically for your App Team Carolina work.Run the following command in your Terminal (while "cd'ed" into your App Team directory) to clone this repo. Replace the `https://github.com/REPO_NAME` with the actual URL of your repo.

   ```bash
   # git clone https://github.com/REPO_NAME
   ```

2. Open the `p01-choosey.xcodeproj` file with Xcode.

## Setup

This project uses the [Yelp Business Search API](https://www.yelp.com/developers/documentation/v3/business_search) to search for restaurants in Chapel Hill.
1. Open the project in Xcode.
2. Poke around and explore the code a little bit.
3. Run your project using **⌘+R** or by pressing the **►** button in Xcode.
4. Wait for the app to build and run, then play around with the app in the Simulator.

### Tasks

- [ ] Find `BusinessListViewModel.swift`

- [ ] Add some code to the beginning the `getPlaces()` method so that if `searchTerm` is empty, you empty the `businesses` array and return.

- [ ] Add a method called `getBestRestaurantId` to the `BusinessListViewModel` class that:

  - [ ] Accepts an array of businesses called `businesses` as a parameter.

  - [ ] Returns a value of type `String?`.

  - [ ] In this function, use a `for` loop to find the business with the highest rating. Return that business's `id`.

    > Hint: the `Business` type has properties called `rating` and `id`. `rating` is a Double representing the business's rating (out of 5), and `id` is a String containing a unique identifier for a given business.
 
### Optional Tasks
- [ ] Make the `Business` struct printable. Look into the `CustomStringConvertible` protocol and making a computed property called `description` that returns a string.

   - [ ] Check if this works using the `print()` method. Maybe call this in the `getPlaces()` method.
   
- [ ] Make a computed property called `verbalPricing` that returns a `String` representing (qualitatively) how expensive a restaurant is based on its `price` property. For example, if `price` is `"$"` or `"$$"`, the value of this property should be "cheap".

   - [ ] For this one, try using a `guard` statement to unwrap the `price` property, which is of the `Optional` type `String?`

- [ ] Make an `enum` called `VerbalRating`. This will be how we convert the `Double` value of `rating` to something a little more human-readable. It should enumerate a few possible ratings: `good, bad, mid`.

   - [ ] The `enum` should have a `static` function that accepts the rating as a `Double`. It should then return one of the three possibilities: `.bad` is any rating in [0,2), `.mid` is any rating in [2,4), etc. Use a switch statement for this.
   
   - [ ] Create a function in the `enum` called `getStringRepresentation()` that returns a `String` descriptor. This function should use a `switch` statement on `self` and have representations for `case .bad`, `case .mid`, etc.
   
   - [ ] Add a new computed property called `verbalRating` of type `VerbalRating` to the `Business` struct. It should call the constructor of `VerbalRating`. 
   
- [ ] Make a `fakeReview` computed property that returns a fake review constructed with string interpolation. Have it incorporate data from the `struct` itself. Use the `getStringRepresentation()` method of `verbalRating`. Maybe have the review mention the city the restaurant is in. 

- [ ] Freestyle some more! Maybe change the `BusinessView` to display some more data from the `Business` model.
   
