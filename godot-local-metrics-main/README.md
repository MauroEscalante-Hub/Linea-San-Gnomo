# Métricas locales para Godot Engine 4.x

Este addon permite trackear métricas customizadas y alamacenar los resultados en un archivo csv
las métricas se almacenan por sesiones, los desarrolladores deben encargarse de decidir
cuando comienza o termina una sesión y cuando se guardan las sesiones en el csv.


## Como añadir el addon al proyecto

1. Copiar la carpeta `local_metrics` en su proyecto.
2. Cargar el archivo `metrics.gd` como autoload
3. Crear un nuevo recurso del tipo `metric_resource`
4. Aditar el nuevo recurso creado añadiendo todas las métricas deseadas.

Ya está listo para comenzar a utilizar.

## Como utilizar las funciones

El orden de ejecución obligatorio es el siguiente:

1. register_metrics
2. record_set | record_add
3. start_new_session
4. export_to_csv -> Cuando se considere que las sesiones creadas deben ser almacenadas

*register_metrics:*
Registro inicial de métricas del archivo resource creado previamente.
Es indispensable llamar este método al inicio del motor ya que es quien registrará en el script
todas las métricas configuradas en el archivo de recurso, así como los tipos de datos
Además este método validará si hay un archivo previamente exportado de métricas
e inicializará el nro de sesión desde uno mas que el último que haya guardado en el csv.

*record_set | record_add:*
Métodos para trackear métricas a lo largo de una sesión.

*start_new_session:*
Cuando una sesión se considera finalizada (ej, al presionar reiniciar)
este método permite almacenar temporalmente todos los datos de la sesión para su posterior escritura en el archivo final de métricas.
Luego crear una nueva sesión para comenzar desde 0.

*export_to_csv:*
Toma todas las sesiones pendientes de guardar y las exporta a un archivo csv.
Si el archivo csv existia previamente, este método alamenará las nuevas sesiones desde la última linea
sin sobreescribir las sesiones previas. Caso contrario, creará un nuevo archivo.
