#!/bin/bash

# arg is bin path
function cpdepts(){

    echo $@

    mkdir -p /home/tester/test_root$(dirname $1)
    sudo cp $1 /home/tester/test_root$1

    info=$(ldd $1)
    while IFS="" read -r p || [ -n "$p" ]
    do

    file=$(echo $p | awk '{print $3}')

    if [ ! -f "$file" ]; then
        file=$(echo $p | awk '{print $1}')
    fi

    if [ ! -f "$file" ]; then
        file=$(sudo find /usr/ -type f -name "$file" 2>/dev/null)
    fi

    echo "line: $p"
    echo "file: $file"

    set -x
    if [ -f $file ];then
        mkdir -p /home/tester/test_root$(dirname $file)
        sudo cp $file /home/tester/test_root$(dirname $file)/$(basename $file)
    fi
    set +x

    done <<< "$info"

}


bins="/bin/bash /usr/bin/cp /usr/bin/ls /usr/bin/curl /usr/bin/wget"

for j in $bins
do
    cpdepts $j
done

sudo chown -R tester:tester /home/tester/

