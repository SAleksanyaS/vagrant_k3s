#!/bin/bash

# Создание переменной окружения для установки worker-узла

if export INSTALL_K3S_EXEC="agent --server https://192.168.42.110:6443 -t $(cat /vagrant/token.env) --node-ip=192.168.42.111"; then
        echo -e "export INSTALL_K3S_EXEC SUCCEEDED"
else
        echo -e "export INSTALL_K3S_EXEC FAILED"
fi

# Установка worker-узла

if curl -sfL https://get.k3s.io | sh -; then
	echo -e "K3s WORKER installation SUCCEEDED"
else
	echo -e "K3s WORKER installation FAILED"
fi

# Команда "sudo ip link add eth1 type dummy" создает виртуальный сетевой интерфейс с именем eth1
# Команда "sudo ip addr add 192.168.42.111/24 dev eth1" присваивает IP-адрес 192.168.42.111 с маской подсети /24
# Заключительная часть, sudo ip link set eth1 up, активирует интерфейс eth1.

if sudo ip link add eth1 type dummy && sudo ip addr add 192.168.42.111/24 dev eth1 && sudo ip link set eth1 up; then
echo -e "add eth1 SUCCEESSFULLY"
else
echo -e "add eth1 FAILED"
fi

# Удаляем токен для безопасности, а также чтобы при перезапуске использовался новый токен, а не ранее созданный

sudo rm /vagrant/token.env
