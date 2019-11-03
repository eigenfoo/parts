.PHONY: help venv black
.DEFAULT_GOAL = help

PYTHON = python3
PIP = pip3
CONDA = conda
SHELL = bash

help:
	@printf "Usage:\n"
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1;34mmake %-10s\033[0m%s\n", $$1, $$2}'

venv:  # Set up a Python virtual environment for development.
	@printf "Creating Python virtual environment...\n"
	rm -rf venv
	${PYTHON} -m venv venv
	( \
	source venv/bin/activate; \
	${PIP} install -U pip; \
	${PIP} install -r requirements.txt; \
	deactivate; \
	)
	@printf "\n\nVirtual environment created! \033[1;34mRun \`source venv/bin/activate\` to activate it.\033[0m\n\n\n"

black-style:
	@printf "Checking code style with black...\n"
	black --check --diff src/
	@printf "\033[1;34mBlack passes!\033[0m\n\n"

pylint-style:
	@printf "Checking code style with pylint...\n"
	pylint src/
	@printf "\033[1;34mPylint passes!\033[0m\n\n"

black:  # Format code in-place using black.
	black src/

lint: black-style pylint-style  # Lint code using black and pylint.
