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

EXCLUDE=(".idea" ".git"  "references" "venv" "__pycache__" "dist" ".gitignore"
         "LICENSE" "README.md" "commands.sh" "history.log" "example*.*"
         "tmp*.*" "temp*.*")
for i in "${!EXCLUDE[@]}"
do
  EXCLUDE[i]="--exclude=${EXCLUDE[i]}"
done


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
    rsync -azq "${EXCLUDE[@]}" $PWD/ alex@$SERVERNAME:$SERVERDIR
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
    rsync -azq "${EXCLUDE[@]}" $PWD/ $DISTDIR
    echo -e "--------------------------------------------\n"
else
    # Не копировать
    echo -e "--------------------------------------------\n"
fi
