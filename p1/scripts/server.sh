#!/bin/bash

# Создание переменной окружения для установки master-узла

if export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san serverS --node-ip 192.168.42.110 --bind-address=192.168.42.110 --advertise-address=192.168.42.110 "; then
    echo -e "export INSTALL_K3S_EXEC SUCCEEDED"
else
    echo -e "export INSTALL_K3S_EXEC FAILED"
fi

# Установка master-узла

if curl -sfL https://get.k3s.io | sh -; then
    echo -e "K3s MASTER installation SUCCEEDED"
else
    echo -e "K3s MASTER installation FAILED"
fi

# Копирование токена Vagrant в смонтированную папку, что необходимо для установки worker-узла

if sudo cat /var/lib/rancher/k3s/server/token >> /vagrant/token.env; then
    echo -e "TOKEN SUCCESSFULLY SAVED"
else
    echo -e "TOKEN SAVING FAILED"
fi

# Команда "sudo ip link add eth1 type dummy" создает виртуальный сетевой интерфейс с именем eth1
# Команда "sudo ip addr add 192.168.42.110/24 dev eth1" присваивает IP-адрес 192.168.42.110 с маской подсети /24
# Заключительная часть, sudo ip link set eth1 up, активирует интерфейс eth1.

if sudo ip link add eth1 type dummy && sudo ip addr add 192.168.42.110/24 dev eth1 && sudo ip link set eth1 up; then
    echo -e "add eth1 SUCCEESSFULLY"
else
    echo -e "add eth1 FAILED"
fi
