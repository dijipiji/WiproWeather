README

Developed with Xcode Version 10.2.1

iOS deployment target is 12.2 and written with Swift 5.0

Please open in Xcode and hit the run button on the target simulator to see.

Please also run the unit tests in WeatherAppTests.swift which test the service & parser by clicking on the appropriate test.

--------

Things I would want to acheive with more time:

• more error checking and tests
• more data sanitization and more defensive programming with some of the optionals and assumptions around those
• better filtering of the weather dataset against each day
• localization for text
• a stylesheet which works for light mode and dark mode ( currently I have presented a dark mode version of the UI )
• more discreet component based programming for the ViewController sub-views
• making it work with the production API ( this example uses samples.openweathermap.org for data and the sample data is from January 2017 )
• making it work with orientation changes for portrait/landscape
• adding more weather icons for all the weather types
• adding more detailed weather info for each day ( using the full weather data displayed instead of the quick filtered data for speed )

