#!/bin/bash

read -p "Введите имя пользователя git: " NAME

if [ -z "$NAME" ]; then
  echo "Имя пользователя git не может быть пустым!"
else
  echo "Имя пользователя: $NAME"
fi

read -p "Введите почту git: " MAIL

if [ -z "$MAIL" ]; then
  echo "Email git не может быть пустым!"
else
  echo "Почта: $MAIL"
fi

git config user.name "$NAME"
git config user.email "$MAIL"

git config --local --list
