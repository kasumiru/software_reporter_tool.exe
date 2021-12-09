#!/bin/bash

cd /cygdrive/c/Windows/system32/
taskkill /im software_reporter_tool.exe /f
cd -

multiple_cmd() {
    echo "fn = $1"
    file_to_block="$2"
    BASEDIR=$(dirname "$1")
    echo "basedir = $BASEDIR"
    echo "FOLDER IS = `pwd`"

    cd "${BASEDIR}"
    set -x
    echo "Find file to block ::::::  $2"
    ICACLS  "$file_to_block" /deny "SYSTEM:(RX)" /C
    #ICACLS "$file_to_block" /deny "root:(RX)" /C
    ICACLS  "$file_to_block" /deny "Administrators:(RX)" /C
    set +x
    cd -
};

export -f multiple_cmd;

#### !!
# внимание!! надо указывать название файла в двух местах. у меня не получилось сделать что бы multiple_cmd принимал переменную, а не просто строковый параметр
#### !!


filename="software_reporter_tool.exe"
#find /cygdrive/c/main-4/Chrome -iname ${filename} -exec bash -c 'multiple_cmd "$0" "software_reporter_tool.exe"' {} \; #1>/dev/null
#find /cygdrive/c/ -iname ${filename} -exec bash -c 'multiple_cmd "$0" "software_reporter_tool.exe"' {} \; #1>/dev/null
find /cygdrive/c/ -iname ${filename} -exec bash -c 'multiple_cmd "$0" "software_reporter_tool.exe"' {} \; #1>/dev/null
