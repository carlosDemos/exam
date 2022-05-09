# TMDB

## Notas
  ### Me es imposible dado el poco tiempo que dispongo darle un formato adecuado a este projecto, y llevarlo a cabo como es debido
      Tengan en cuenta que 48hs / un fin de semana no son suficientes.
  
  Les comento brevemente las cosas que se le podrian agregar con mas tiempo.
   - Un TabView en el ingreso del projecto para poder buscar entre las peliculas (on/off line)
   - Un CollectionView para los detalles de las peliculas.
   - Las restantes unit tests para las demas clases y presenters (solo testee 3), puedo testear todo pero no de inmediato.
   - Algunas integration tests para corroborar el correcto funcionamiento del producto.

Despues de mayo 26 la CI va a empezar a fallar porque github hace un update del xcode que tiene instalado a la version 13.3

## Preguntas

### Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y qué clases pertenecen a cual.

En este caso el projecto creado cuenta con 5 capas

- Networking = TMDBNetworkingService
- Navigation = TMDBMainCoordinator
- Business = TMDBInitialScreenPresenter, TMDBDetailedMovieScreenPresenter, TMDBDetailedMovieScreen
- Views = TMDBInitialScreenSectionHeaderTitle, TMDBMovieCell
- Controllers = todas las que terminan en controller

### La responsabilidad de cada clase creada.

La responsabilidad de cada una de las capas creadas tiene que ver con el nombre que se le dio a ellas y son bastante auto explicativas

### En qué consiste el principio de responsabilidad única? Cuál es su propósito?

Una clase debe tener solamente una razon para ser modificada.
Su proposito es que cada clase cumpla solamente una funcion y no multiples.
Navegacion, Networking, Business logic, View, etc.

### Qué características tiene, según su opinión, un “buen” código o código limpio
 
 El codigo limpio debe estar testeado, y estar dividido en sus responsabilidades.
 Cada clase debe cumplir con una funcion y la misma debe estar testeada.
 El mismo debe ser claro y legible, no me gusta agregar comentarios en el codigo, y el mismo debe ser explicativo.
 
 
