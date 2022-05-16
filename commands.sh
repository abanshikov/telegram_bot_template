#!/bin/bash

SERVERPART=(${PWD//\// })
SERVERDIR=$HOME/bots/${SERVERPART[-1]}
DISTDIR=$PWD/references/dist/

echo "Удаление служебных каталогов и файлов python"
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

# исключаемые каталоги и файлы
  exclude_dir_1='.idea'
  exclude_dir_2='.git'
  exclude_dir_3='references'
  exclude_dir_4='venv'
  exclude_dir_5='__pycache__'
  exclude_dir_6='dist',
  exclude_file_1='.gitignore'
  exclude_file_2='LICENSE'
  exclude_file_3='README.md'
  exclude_file_4='commands.sh'
  exclude_file_5='history.log'

PS3='Копировать проект на сервер: '
select COPYTOSERVER in "Да" "Нет"
do
  break
done

if [[ $COPYTOSERVER == "Да" ]]; then

  PS3='На какой сервер скопировать бота: '
  select SERVERNAME in "regru" "homeserver"
  do
    break
  done

  echo "Копирование проекта на сервер в каталог "$SERVERDIR

  ssh alex@$SERVERNAME "mkdir -p $SERVERDIR"
  rsync   -azq \
          --exclude=$exclude_dir_1 --exclude=$exclude_dir_2 \
          --exclude=$exclude_dir_3 --exclude=$exclude_dir_4 \
          --exclude=$exclude_dir_5 -exclude=$exclude_dir_6 \
          --exclude=$exclude_file_1 --exclude=$exclude_file_2 \
          --exclude=$exclude_file_3 --exclude=$exclude_file_4\
          --exclude=$exclude_file_5 \
          $PWD/ alex@$SERVERNAME:$SERVERDIR
fi

echo "Копирование проекта в "$DISTDIR
mkdir -p $DISTDIR
rsync   -azq \
        --exclude=$exclude_dir_1 --exclude=$exclude_dir_2 \
        --exclude=$exclude_dir_3 --exclude=$exclude_dir_4 \
        --exclude=$exclude_dir_5 -exclude=$exclude_dir_6 \
        --exclude=$exclude_file_1 --exclude=$exclude_file_2 \
        --exclude=$exclude_file_3 --exclude=$exclude_file_4\
        --exclude=$exclude_file_5 \
        $PWD/ $DISTDIR


