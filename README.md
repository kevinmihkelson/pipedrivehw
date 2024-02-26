# Test Assignment for Pipedrive iOS developer role

## The goal of the application.

Build a simple master-detail application that displays a list of people from your Pipedrive account (to get
the list, use /persons endpoint).
The app should contain:

A screen with the list of people obtained from Pipedrive API
A screen with each person details that is accessible from the list screen

## How to compile and run the application
This application is written in Swift and requires the Swift Package Manager. To compile and run the application, you will need to:

1. Install the Swift Package Manager.
2. Clone the repository to your local machine.
3. Open the project in Xcode.
4. Run the following command in the project directory:
swift package update

This will install the dependencies and update the project's Xcode project file.
5. Update the APIKey value in the APIRouter
6. Click on the Play button in Xcode to run the application.

The application should now be running.

## How to run tests for the application
This application uses the XCTest framework to run unit tests. To run the tests, you will need to do the following:

1. Open the project in Xcode.
2. Click on the "Test" navigator.
3. Select the tests that you want to run.
4. Click on the "Play" button in the toolbar.

The tests will now be run.

## App architecture

I used the Model-View-ViewModel (MVVM) pattern for this project.

This application is structured as follows:

* **The presentation layer**
    * The views are responsible for displaying the data.
    * The view models are responsible for providing the views with the data that they need.
    
* **The data layer**
    * The Service class is responsible for fetching data from the REST API.
    * The APIClient class is responsible for making HTTP requests to the REST API.
    * The APIRouter class is responsible for mapping URLs.
    * The CoreDataManager is responsible for fetching and saving data locally 

If the phone isn't connected to the internet then the application will fetch the latest locally saved data. 

I also added localization for the application for the estonian and english langugage. It'll change the applications translations if you change your preferred languages in the phones settings.

### Models 

The following models are used in the REST API:

* **Person**
    * id: **Int** - A unique identifier for the person
    * name: **String?** - The full name of the person, combining first and last name 
    * firstName: **String?** - The first name of the person
    * lastName: **String?** - The last name of the person
    * isActive: **Bool?** - Indicates whether the person is active or not
    * orgName: **String?** - The name of the organization associated with the person
    * phone: **[PersonContact?]?** - An array of contact information for the person, consists of phone numbers associated with the person
    * email: **[PersonContact?]?** - An array of contact information for the person, consists of emails associated with the person
    * updateTime: **Date?** - The date and time when the person's information was last updated
    * addTime: **Date?** - The date and time when the person was added
    * notes: **String?** - Additional notes or information about the person
    * birthday: **String?** - The birthday of the person
    * jobTitle: **String?** - The job title or role of the person
    * imageURL: **String?** - The URL of the person's image
    
* **ResponseModel**
    * success: **Bool** - Indicates whether the request was successful or not  
    * data: **[T]** - The actual data content, the type T can vary depending on the context
    * additionalData: **AdditionalData?** Additional information related to the response

* **PersonContact**
    * label: **String?** - A label for the contact information (e.g., "Mobile", "Work").
    * value: **String?** - The actual contact information (e.g., phone number, email address).
    * primary: **Bool?** Indicates whether this is the primary contact information for the specific label (e.g., primary phone number).
    
* **AdditionalData**
    * pagination: **Pagination?** - Information related to pagination, used for endless scroll implementation.
    
* **Pagination**
    * start: **Int** - The index of the first element in the current page of results
    * limit: **Int** - The number of items per page
    * moreItemsInCollection: **Bool** Indicates whether there are more items available beyond the current page
    
The following models are used in the CoreData:

* **PersonMO**
    * id: **Int64** - The unique identifier for the person in the Core Data model
    * name: **String?** - The full name of the person, combining first and last name
    * firstName: **String?** - The first name of the person
    * lastName: **String?** - The last name of the person
    * orgName: **String?** - The name of the organization associated with the person
    * jobTitle: **String?** - The job title or role of the person
    * birthday: **String?** - The birthday of the person
    * notes: **String?** - Additional notes or information about the person
    * addTime: **Date?** - The date and time when the person was added
    * updateTime: **Date?** - The date and time when the person's information was last updated
    * phone: **NSSet?** - A set of PersonContactMO objects representing the person's phone numbers in Core Data
    * email: **NSSet?** -  A set of PersonContactMO objects representing the person's email addresses in Core Data
    
* **PersonContactMO**
    * label: **String?** - The label or type of contact information
    * value: **String?** - The actual contact information
    * primary: **Bool?** - Indicates whether this contact information is the primary or preferred one
    * person: **PersonMO?** - The person entity associated with this contact information

## Things that didn't get done due to time constraints but would've been nice 

* Different targets for potential dev/live environment
* UI Tests
* Make CoreData things more abstract like the APIClient
* Unit tests for CoreData operations
* Better accesibility support
* Git branching, but it seemed pointless for this small project
* Persons notes - API didn't return any of them for some reason
* Persons label
* Better error handling - clearer error messages for user
* Sorting/filtering persons
