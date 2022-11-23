

1. Развёртывание первой ноды (токен генерируем сами):

curl -sfL https://get.k3s.io | K3S_TOKEN='^SH{Ge-jhWHdP<X"lX0A' sh -s - server --cluster init

2. Развёртывание последующих нод (подключаемся к первой ноде по ip:port, порт нужно открыть):

