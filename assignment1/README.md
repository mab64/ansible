Необходимо написать сценарий на Ansible, который будет разворачивать следующие компоненты:
- Nginx;
- PHP;
- MySQL с репликацией master-slave;
- Redis.

Критерии выполнения задачи:
1. Можно использовать любую из популярных ОС: CentOS, Ubuntu, Debian.
2. Для каждого пакета должен быть выбор версии.
3. Должна быть возможноcть настройки или установки отдельного компонента сценария.
4. Nginx должен по умолчанию отдавать index.php со след. содержанием: 
<?php phpinfo(); ?>

####################################################

Установка всех компонентов: файл main.yml.

Перед запуском: файл hosts.yml.default скопировать в hosts.yml, изменить имена хостов.

Переменные определяются в файлах vars.default.yml и vars.yml.
В случае необходимости значения переменных переопределять в файле vars.yml.
Значения переменных файла vars.yml имеют приоритет над vars.default.yml.

Установка компонентов зависит от значений переменных:
- nginx_install
- php_install
- redis_install
- mysql_install
- mysql_replication
Установка компонента выполняется, если значение соответствующей переменной равно 1.

Также можно устанавливать каждый компонент отдельно через соответствующий плейбук:
- ngninx-playbook.yml
- php-playbook.yml
- redis-playbook.yml
- mysql-playbook.yml
- mysql-repl-playbook.yml

Выбор версии кажого компонента производится заданием значений соответствующих переменных:
- nginx_version
- php_version
- mysql_version
- redis_version

Пароль root для MySQL задается в переменной mysql_password.
Имя и пароль пользователя для репликации задаются переменными:
- mysql_repl_user
- mysql_repl_password
 

#######################################

Тестирование, отладка проводились на Remote nodes под управлением OS Centos 7 с включенными SELinux и firewalld.
Версия Ansible на Control node: 2.5.1

Развертывание Remote nodes производилось на Virtualbox через сценарий Vagrant.
Перед запуском:
- скопировать файл Vagrantfile.default в Vagrantfile
- изменить имя сетевого интерфейса в строке 7 файла Vagrantfile.

