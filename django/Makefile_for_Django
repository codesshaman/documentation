name = Django
APPNAME:=$(word 2, $(MAKECMDGOALS))
DIR := $(abspath $(dir $(abspath $(lastword $(MAKEFILE_LIST))))..)
VENV_DIR=.venv
VENV=$(DIR)/$(VENV_DIR)
VENV_BIN=$(VENV)/bin
PYTHON=$(VENV_BIN)/python3
PIP=$(VENV_BIN)/pip3

NO_COLOR=\033[0m		# Color Reset
COLOR_OFF=\e[0m			# Color Off
OK_COLOR=\033[32;01m	# Green Ok
ERROR_COLOR=\033[31;01m	# Error red
WARN_COLOR=\033[33;01m	# Warning yellow

all:
	@printf "$(OK_COLOR)==== Starting the configuration ${name} ====$(NO_COLOR)\n"
	$(PYTHON) manage.py runserver 8888

app:
	@printf "$(OK_COLOR)==== Creating a new application ====$(NO_COLOR)\n"
	@$(eval args := $(words $(filter-out --,$(MAKECMDGOALS))))
	@if [ "${args}" -eq 2 ]; then \
		echo "$(OK_COLOR) Creating an application ${APPNAME}$(NO_COLOR)\n"; \
		cd apps; \
		$(PYTHON) ../manage.py startapp ${APPNAME}; \
		cd ..; \
	elif [ "${args}" -gt 2 ]; then \
		echo "$(ERROR_COLOR)The application name must not contain spaces!$(NO_COLOR)\n"; \
	else \
		echo "$(ERROR_COLOR)Enter the name of the application!$(NO_COLOR)\n"; \
	fi

freeze:
	@$(PIP) freeze

h:
	@printf "$(OK_COLOR)==== Django help ====$(NO_COLOR)\n"
	$(PYTHON) manage.py -h

help:
	@echo -e "$(OK_COLOR)==== All commands of ${name} configuration ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- make app <appname>			: Create new application"
	@echo -e "$(WARN_COLOR)- make freeze		        	: Pip freeze command"
	@echo -e "$(WARN_COLOR)- make				        : Launch configuration"
	@echo -e "$(WARN_COLOR)- make h				: Django reference"
	@echo -e "$(WARN_COLOR)- make help				: Makefile commands reference"
	@echo -e "$(WARN_COLOR)- make install <libname>		: Launch pip install"
	@echo -e "$(WARN_COLOR)- make make				: Make makemigrations"
	@echo -e "$(WARN_COLOR)- make migrate			        : Make migrations"
	@echo -e "$(WARN_COLOR)- make req				: Install pip requirements"
	@echo -e "$(WARN_COLOR)- make root				: Create superuser"
	@echo -e "$(WARN_COLOR)- make static				: Collect static"
	@echo -e "$(WARN_COLOR)- make venv				: Create virtual environment"
	@echo -e "$(WARN_COLOR)- make clean				: Remove python cache"
	@echo -e "$(WARN_COLOR)- make fclean				: Remove venv configuration$(NO_COLOR)"

install:
	@printf "$(OK_COLOR)==== Launch pip install ====$(NO_COLOR)\n"
	@printf "$(OK_COLOR)==== Downloading a new library ====$(NO_COLOR)\n"
	@$(eval args := $(words $(filter-out --,$(MAKECMDGOALS))))
	@if [ "${args}" -eq 2 ]; then \
		echo "$(OK_COLOR) Downloading the library ${APPNAME}$(NO_COLOR)\n"; \
		cd apps; \
		$(PIP) install ${APPNAME}; \
		cd ..; \
	elif [ "${args}" -gt 2 ]; then \
		echo "$(ERROR_COLOR)The library name must not contain spaces!$(NO_COLOR)\n"; \
	else \
		echo "$(ERROR_COLOR)Enter the library name!$(NO_COLOR)\n"; \
	fi

make:
	@printf "$(OK_COLOR)==== Make makemigrations ${name} ====$(NO_COLOR)\n"
	$(PYTHON) manage.py makemigrations

migrate:
	@printf "$(OK_COLOR)==== Launch configuration ${name} ====$(NO_COLOR)\n"
	$(PYTHON) manage.py migrate

req:
	@printf "$(OK_COLOR)==== Install python requirements ====$(NO_COLOR)\n"
	@if [ -d "${VENV}" ]; then \
		$(PIP) install -r ../requirements.txt; \
	else \
		echo "Environment is absent"; \
		echo "In first run the command:"; \
		echo "make venv"; \
	fi

root:
	@printf "$(OK_COLOR)==== Create superuser for ${name} ====$(NO_COLOR)\n"
	$(PYTHON) manage.py createsuperuser

run:
	@printf "$(OK_COLOR)==== Run ${name} ====$(NO_COLOR)\n"
	$(PYTHON) manage.py runserver

static:
	@printf "$(OK_COLOR)==== Collect static ${name} ====$(NO_COLOR)\n"
	$(PYTHON) manage.py collectstatic

venv:
	@printf "$(OK_COLOR)==== Launch virtual environment for ${name} ====$(NO_COLOR)\n"
	@if [ ! -d "${VENV}" ]; then \
        echo "Creating virtual environment..."; \
        python3 -m venv ${VENV}; \
    fi

clean:
	@printf "$(ERROR_COLOR)==== Cleaning cache ${name}... ====$(NO_COLOR)\n"
	@find . -name '*.pyc' -delete
	@find . -name '__pycache__' -type d | xargs rm -fr

fclean: clean
	@printf "$(ERROR_COLOR)==== Cleaning configuration ${name}... ====$(NO_COLOR)\n"
	@rm -rf ${VENV}

.PHONY	: all app freeze h help install make migrate req root static venv vexit clean fclean
