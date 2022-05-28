#!/bin/bash

SERVERPART=(${PWD//\// })
if [[ "$PWD" == *"parser"* ]]; then
    SERVERDIR=$HOME/parsers/${SERVERPART[-1]}
elif [[ "$PWD" == *"bot"* ]]; then
    SERVERDIR=$HOME/bots/${SERVERPART[-1]}
else
    SERVERDIR=$HOME/${SERVERPART[-1]}
fi
DISTDIR=$PWD/dist/

# исключаемые каталоги и файлы
exclude_dir_1='.idea'
exclude_dir_2='.git'
exclude_dir_3='references'
exclude_dir_4='venv'
exclude_dir_5='__pycache__'
exclude_dir_6='dist'
exclude_file_1='.gitignore'
exclude_file_2='LICENSE'
exclude_file_3='README.md'
exclude_file_4='commands.sh'
exclude_file_5='history.log'


# -------------------------------------------------------------------
# Шаг 1. Удаление служебных каталогов
echo -e "Удаление служебных каталогов и файлов python"
echo -e "--------------------------------------------\n"
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf


# -------------------------------------------------------------------
# Шаг 2. Копирование проекта на сервер
read -r -p "Копировать проект на сервер? [y/N] " response
if [[ "$response" =~ ^([yYдД][eEаА][sS]|[yYдД])+$ ]]
then
    # Копировать
    echo -e "Выберите сервер, на который нужно скопировать проект"
    PS3='Сервер (1, 2, ...): '

    select SERVERNAME in "regru" "homeserver"
    do
        break
    done
    echo "Копирование проекта на сервер в каталог "$SERVERDIR
    ssh alex@$SERVERNAME "mkdir -p $SERVERDIR"
    rsync   -azq \
            --exclude=$exclude_dir_1 --exclude=$exclude_dir_2 \
            --exclude=$exclude_dir_3 --exclude=$exclude_dir_4 \
            --exclude=$exclude_dir_5 --exclude=$exclude_dir_6 \
            --exclude=$exclude_file_1 --exclude=$exclude_file_2 \
            --exclude=$exclude_file_3 --exclude=$exclude_file_4\
            --exclude=$exclude_file_5 \
            $PWD/ alex@$SERVERNAME:$SERVERDIR
    echo -e "--------------------------------------------\n"
else
    # Не копировать
    echo -e "--------------------------------------------\n"
fi


# -------------------------------------------------------------------
# Шаг 3. Создание каталога с дистрибутивом проекта
read -r -p "Создать готовый дистрибутив проекта? [y/N] " response
if [[ "$response" =~ ^([yYдД][eEаА][sS]|[yYдД])+$ ]]
then
    # Копировать
    echo "Копирование проекта в "$DISTDIR
    mkdir -p $DISTDIR
    rsync   -azq \
            --exclude=$exclude_dir_1 --exclude=$exclude_dir_2 \
            --exclude=$exclude_dir_3 --exclude=$exclude_dir_4 \
            --exclude=$exclude_dir_5 --exclude=$exclude_dir_6 \
            --exclude=$exclude_file_1 --exclude=$exclude_file_2 \
            --exclude=$exclude_file_3 --exclude=$exclude_file_4\
            --exclude=$exclude_file_5 \
            $PWD/ $DISTDIR
    echo -e "--------------------------------------------\n"
else
    # Не копировать
    echo -e "--------------------------------------------\n"
fi
