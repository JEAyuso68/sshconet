
#!/bin/bash

directorio_script="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
archivo_servidores="$directorio_script/serverssh"
servidores=()

if [[ ! -r "$archivo_servidores" ]]; then
    printf 'No se puede leer el archivo de servidores: %s\n' "$archivo_servidores" >&2
    exit 1
fi

while IFS= read -r linea || [[ -n "$linea" ]]; do
    [[ -z "$linea" || "$linea" =~ ^[[:space:]]*# ]] && continue
    servidores+=("$linea")
done < "$archivo_servidores"

if (( ${#servidores[@]} == 0 )); then
    printf 'El archivo de servidores está vacío: %s\n' "$archivo_servidores" >&2
    exit 1
fi

while true; do
    clear
    echo "======================================"
    echo "       CONEXIONES SSH"
    echo "======================================"
    echo

    for i in "${!servidores[@]}"; do
        IFS='|' read -r nombre host usuario puerto <<< "${servidores[$i]}"
        printf "  %2d) %-18s %s@%s:%s\n" \
            "$((i+1))" "$nombre" "$usuario" "$host" "$puerto"
    done

    echo
    echo "   0) Salir"
    echo
    read -rp "Selecciona un servidor: " opcion

    if [[ "$opcion" == "0" ]]; then
        exit 0
    fi

    if [[ "$opcion" =~ ^[0-9]+$ ]] &&
       (( opcion >= 1 && opcion <= ${#servidores[@]} )); then

        IFS='|' read -r nombre host usuario puerto <<< "${servidores[$((opcion-1))]}"

        echo
        echo "Conectando a $nombre..."
        echo

        ssh -p "$puerto" "$usuario@$host"

        echo
        read -rp "Pulsa ENTER para volver al menú..."
    else
        echo
        echo "Opción no válida."
        sleep 1
    fi
done