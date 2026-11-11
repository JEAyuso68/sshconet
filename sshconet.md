creación de un scrip en bash para conectarme a mis servidores mediante ssh
sin tener que recordar url, usuario, puerto y otras consideraciónes.
a ver que sale.
Los datos de los servidores son inventados y deben ser actualizados antes de su uso

## Configuración

El script lee la lista de servidores desde el archivo `serverssh`, ubicado en
el mismo directorio que `sshconet.sh`. Añade un servidor por línea con este
formato:

```text
nombre|host|usuario|puerto
```

Por ejemplo:

```text
servidor-web|example.net|usuario|22
servidor-pruebas|192.168.1.20|admin|2222
```

Las líneas vacías y las que comienzan con `#` se ignoran. Sustituye los
valores de ejemplo por los datos reales de tus servidores. El archivo debe
existir y ser legible para ejecutar el script.
