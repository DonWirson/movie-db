# movie_db: Un proyecto.

Se utilizó Claude para hacer código repetitivo como generar eventos y estados de bloc siguiendo el patrón ya hecho a mano previamente.

>   Se utiliza de forma granular, paso a paso en vez de enviar el módulo entero para que lo realice, se explica paso a paso con el componente específico que debe interactuar en cada paso, luego de eso se revisa que el código siga la estructura de proyecto y convención de nombres.


## Cómo levantar el proyecto

Este proyecto usa Flutter `3.44.6`.

1.  Instalar/usar Flutter `3.44.6` (por ejemplo con FVM: `fvm use 3.44.6`).
2.  Instalar las dependencias:
    ```
    flutter pub get
    ```
3.  Crear el archivo `.env` en la raíz del proyecto (mismo nivel que `pubspec.yaml`) a partir de [.env_example](.env_example), y completar con la API key de [The Movie Database](https://www.themoviedb.org/):
    ```
    API_KEY_MOVIE_DB=tu_api_key_aqui
    ```
4.  Correr el generador de código (envied genera `lib/config/env/env.g.dart` a partir del `.env`):
    ```
    dart run build_runner build --delete-conflicting-outputs
    ```
5.  Levantar la app:
    ```
    flutter run
    ```

Pendientes:

*  Rellenar los tab de la vista de Home: 
 Para hacer esto haría algo similar al componente "top_watched_movies.dart", en el cual se separa el componente del home y se gatilla en este el evento que va a buscar las películas de este tab, esta modularidad ayuda mucho a desacoplar la búsqueda de data de la UI.

*   Con el resto de tab similar.

*   La animación Hero quedó un poco rara, en teoría esta hace que la imagen de la película salte y quede un efecto de continuidad al ir a la vista de detalles, pero como agregué un evento para buscar de forma independiente la búsqueda de detalles, quedó con un spinner de carga que evita que se vea bien, probablemente reutilizaría la data de película que ya tengo, en vez de buscar un detalle por id de película.

*   Pruebas unitarias por falta de tiempo se generaron con IA, pero no tengo problema en mostrar en otros proyectos reales test unitarios generados y demás evidencias de estos.

*   adjunto de paso un video de aplicación de chat que hice el año pasado con flutter 3: 
https://drive.google.com/file/d/1lCDvCeRM_Vx9DXG2w0bw4Tuc1EVFkd75/view?usp=drive_link


