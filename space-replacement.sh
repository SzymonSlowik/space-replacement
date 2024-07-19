#!/bin/bash

currentl_directory=".";
yes="";

function yes_or_no {
	local prompt="$1"
	yes=0;
	local attempts=0;


	while [ "$attempts" -lt 3 ]; do 
		echo "y/n";
		sleep 1;
		read -r yn;
		case $yn in
			y)
				yes=1;
				return;
				;;
			n)
				yes=2;
				return;
				;;
			*)
                        	echo "Nieznana opcja, jeżeli chcesz zamknąć wciśnij q"
				attempts=$((attempts+1));	
				;;
		esac
	done

	echo "Błąd";
	exit 1;
}


function auto {
        echo -e "Czy zamienić automatycznie";
	yes_or_no;

        case "$yes" in
                1)
                        replace_auto;
			;;
                2)
                        replace_man;
                        ;;
        esac
}

function replace_auto {
	while read -r line
	do
		local new=${line// /-};
        	new=${new//_/-};
        	new=${new//,/-};
        	new=${new//---/-};
        	new=${new//--/-};
        	new=${new//-./-};

		if [ "$line" != "$new" ]; then
                	echo -e "$line\n|\nV\n$new\n$separator"
       		fi
	done < list
}

function replace_man {
        while read -r line
        do
                local new=${line// /-};
                new=${new//_/-};
                new=${new//,/-};
                new=${new//---/-};
                new=${new//--/-};
                new=${new//-./-};

                if [ "$line" != "$new" ]; then
                        echo -e "Czy zamienić:\n$line\nna\n$new"
			yes_or_no;
			if [ "$yes" -eq "1" ]; then
				echo "nazwa zmieniona"
			fi
                fi
	done < list
}


\ls $currentl_directory > list;
auto;

