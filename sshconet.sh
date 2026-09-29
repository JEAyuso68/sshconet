
#!/bin/bash

# Lista de servidores
servidores=(
    "Server|192.168.xxx.xxx|root|22"
    "webserver|yourdomain.net|user1|22"
    "Server4|192.168.xxx.xxx|user5|22"
    "Server5|192.168.xxx.xxx|user9|22"
)

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