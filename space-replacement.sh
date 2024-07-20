#!/bin/bash

yes=""
auto=""

function yes_or_no {
    yes=0
    local attempts=0

    while [ "$attempts" -lt 3 ]; do 
        echo "y/n"
        read -r yn
        case "$yn" in
            y)
                yes=1
                return
                ;;
            n)
                yes=2
                return
                ;;
            *)
                echo "Nieznana opcja"
                attempts=$((attempts+1))    
                ;;
        esac
    done

    echo "Błąd"
    exit 1
}

function automatic {
    echo -e "Czy zamienić automatycznie?"
    yes_or_no

    case "$yes" in
        1)
            auto=1
            ;;
        2)
            auto=0
            ;;
    esac
}

function replace {
    for file in *; do
        if [ -d "$file" ]; then
            continue
        fi

        local new=${file// /-}
        new=${new//_/-}
        new=${new//,/-}
        new=${new//---/-}
        new=${new//--/-}

        if [ "$file" != "$new" ]; then
            if [ "$auto" -eq "1" ]; then
                echo -e "zamiana:\n$file\nna:\n$new\n"
                mv "$file" "$new"

            elif [ "$auto" -eq "0" ]; then
                echo -e "Czy zamienić:\n$file\nna\n$new?"
                yes_or_no < /dev/tty # Wczytuje tylko dane z klawiatury

                if [ "$yes" -eq "1" ]; then
                    echo "nazwa zmieniona"
                    mv "$file" "$new"
                fi
            fi
        fi
    done
}

automatic
replace

