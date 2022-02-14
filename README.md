# Telegram bot template

Шаблон для создания проекта телеграм бота.


# Запуск на сервере с помощью systemd

1. Подключиться к серверу и выполнить [настройку сервера](https://github.com/abanshikov/server_settings)
2. Скопировать проект на сервер в удобную директорию, например `/home/client/test_bot`. 
3. Установить виртуальное окружение и необходимые зависимости
4. Отредактировать файл `telegram_bot.service` в части:
     - Description - описание бота;
     - User - имя пользователя linux;
     - WorkingDirectory - путь до `main.py`;
     - ExecStart - #1 путь к интерпретатору, #2 путь скрипту
5. Скопировать файл
```bash
$ sudo cp ./telegram_bot.service /etc/systemd/system
```
6. Запуск:
```bash
$ sudo systemctl enable telegram_bot && sudo systemctl start telegram_bot && sudo systemctl status telegram_bot
```
7. Остановка:
 ```bash
$ sudo systemctl disable telegram_bot && sudo systemctl stop telegram_bot && sudo systemctl status telegram_bot
``` 
8. Перезапуск:
```bash
$ sudo systemctl daemon-reload
``` 