# Установка Docker в Windows

## Шаг 1. Включите подсистему Windows для Linux.

Вы должны сначала включить дополнительную функцию **«Подсистема Windows для Linux»**, прежде чем устанавливать какие-либо дистрибутивы Linux в Windows.

Откройте PowerShell от имени администратора и введите следующую команду:

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

# Шаг 2. Включите функцию виртуальной машины

Перед установкой WSL 2 необходимо включить дополнительную функцию платформы виртуальных машин. Для использования этой функции вашей машине потребуются возможности виртуализации.

Откройте PowerShell от имени администратора и выполните:

```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

# Шаг 3. Загрузите пакет обновления ядра Linux.

Скачать и установить:
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

# Шаг 4. Установите WSL 2 в качестве версии по умолчанию.

Откройте PowerShell и выполните эту команду, чтобы установить WSL 2 в качестве версии по умолчанию при установке нового дистрибутива Linux:

```
wsl --set-default-version 2
```

# Шаг 5. Установите выбранный вами дистрибутив Linux.

Откройте Microsoft Store и выберите свой любимый дистрибутив Linux. Если не знаете, какой линукс выбрать, устанавливайте debian.

