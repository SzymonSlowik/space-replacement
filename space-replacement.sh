#!/bin/bash

directory="$HOME/syncthing/H/Z_H-Videos";

\ls $directory > file_list;

i=0;

rm file_list_new;

while read line
do
        
        new=${line// /-};
        new=${new//_/-};
        new=${new//,/-};

        new=${new//---/-};
        new=${new//--/-};
        new=${new//-./-};

        echo -e "$line\n$new" >> file_list_new;

done < file_list

rm file_list;
