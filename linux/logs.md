# Логи Linux

Основная папка логов: **/var/log**

Файл лога  |  Назначение
------ | ------
**syslog** | главный системный лог
**auth.log** | все попытки входа на сервер + ip
**dmesg** | лог драйверов
**dpkg.log** | лог менеджера пакетов
**faillog** | лог неудачных попыток входа в систему

## Команды для получения информации о системе:

**who** - кто на данный момент находится в системе

**last** - когда и насколько пользователь заходил в систему

**last** ***username***  - информация по конкретному пользователю

**lastlog** - все пользователи с датами последнего входа