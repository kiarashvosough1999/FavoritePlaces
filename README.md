# Favorite Places article with MVVM +  Repository + Coordinator Architecture
Favorite Places is an app which works with GoogleMap and user can assign different location for person he/she created before to keep track of their favorite locations.

## To run the project:
- You can easily get your GoogleMap API KEY from developers.google.com
- Then put your APIKey in UserDefaultsConfig.Swift file ->  @UserDefault(.googleAPIToken).
- Make sure to install all pods using pod install in Terminal.

## More Info

Repository pattern was impelemented only on `FavoritePlacesViewModel`. for the case you wanna check

other viewModel will be soon use repository.

### Current Features:
- Used MVVM + Coordinator + Repository Architect
- Localization: Currently Supports English
- Will Have two Enviroments: Development and Production
- Modularized
- Animatable Place Marker
- Custom map styled
