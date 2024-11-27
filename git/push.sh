# Выводим git status

git status
# Запрашиваем пользовательский ввод для выполнения пуша
read -p "Хотите выполнить пуш? (y/n): " answer

# Если пользователь ввел "y" или "Y", продолжаем выполнение
if [[ $answer == "y" || $answer == "Y" ]]; then
    # Выполняем git add .
    git add .

    # Выводим git status после git add .
    git status

    # Запрашиваем текст коммита от пользователя
    read -p "Введите коммит: " commit_message

    # Выполняем git commit с введенным пользовательским сообщением
    git commit -m "$commit_message"

    # Выполняем git push
    git push
fi

git status
