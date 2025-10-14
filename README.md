# WSL Ecosystem

[![GitHub](https://img.shields.io/badge/View_on-GitHub-black?logo=github)](https://github.com/linux-utils/bash-aliases)
[![MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

## Описание

Автоматическое решение для настройки WSL (Windows Subsystem for Linux), которое добавляет запись в файл `/etc/hosts` для удобного доступа к WSL из Windows по доменному имени `wsl.host`.

## Что делает система

### Скрипт `startup.sh`
- **Определяет IP-адрес WSL** из `/etc/resolv.conf`
- **Удаляет старые записи** `wsl.host` из `/etc/hosts`
- **Добавляет новую запись** в формате: `[WSL-IP] wsl.host`
- **Предотвращает дублирование** записей
- **Обеспечивает разрешение** доменного имени `wsl.host`

### Конфиг WSL
- Включает **systemd** для управления службами
- Устанавливает **hostname** = `wsl`

## Установка
1. Добавьте файл [`startup.sh`](/src/startup.sh) в корень wsl дистрибутива.
2. Выполните консольную команду
```bash
# WSL terminal
sudo chmod +x ~/startup.sh && echo "sudo /startup.sh" | sudo tee -a /etc/profile
```
3. Убедитесь в наличии файла `/etc/wsl.conf`. Если файла нет, то создайте его.
```bash
# WSL terminal
sudo [ -f "/etc/wsl.conf" ] || sudo touch /etc/wsl.conf
```
4. Возьмите конфигурацию файла [`wsl.conf`](/src/etc/wsl.conf) за основу, и перенесите её к себе.
5. Перезагрузите wsl. Для этого в **PowerShell** терминале выполни команду
```shell
# Windows PowerShell terminal
wsl --shutdown
```

## Проверка работы

После перезагрузки WSL откройте терминал и проверьте:

```bash
# WSL terminal
# Проверьте запись в hosts
cat /etc/hosts | grep wsl.host
```
```bash
# Windows PowerShell terminal
# Проверьте пинг из Windows (PowerShell)
ping wsl.host
```
