#! /bin/bash

# List of ANSI colors
BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
BROWN="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
LIGHT_GRAY="\[\e[0;37m\]"
# List of ANSI colors combinations
DARK_GRAY="\[\e[1;30m\]"
LIGHT_RED="\[\e[1;31m\]"
LIGHT_GREEN="\[\e[1;32m\]"
YELLOW="\[\e[1;33m\]"
LIGHT_BLUE="\[\e[1;34m\]"
LIGHT_PURPLE="\[\e[1;35m\]"
LIGHT_CYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"

# Colors special characters
RESET_COLOR="\[\e[0m\]" 	# end color modifications.

function paint()
{
	forground_color=$1
	background_color=$2
	text="${"*":3}"

	echo -en "${forground_color};${background_color}${text}${RESET_COLOR}"
}

function conda_env_name()
{
	CONDA_ENV_NAME="${CONDA_DEFAULT_ENV}"
}

function conda_env_name_with_color()
{
	if [[ "${CONDA_PREFIX}" != "" ]]; then
		conda_env_name
		CONDA_ENV_NAME_WITH_COLOR="${CYAN}[${CONDA_ENV_NAME}]${RESET_COLOR}"
	fi
}

function python_virtualenv_name_with_color()
{
	if [[ "${VIRTUAL_ENV}" != "" ]]; then
		VIRTUAL_ENV_NAME="${VIRTUAL_ENV}"
		PYTHON_VIRTUAL_ENV_COLOR_NAME="${LIGHT_BLUE}(${VIRTUAL_ENV_NAME})${RESET_COLOR}"
	fi
}

PROMPT_COMMAND=bash_prompt_command
function bash_prompt_command()
{
	local EXIT_CODE="$?"
	PS1=""

	# First show the conda environment
	if [[ "${CONDA_PREFIX}" != "" ]]; then
		conda_env_name_with_color
		PS1+="${CONDA_ENV_NAME_WITH_COLOR}"
	fi

	# At second show python virtualenv name
	if [[ "${VIRTUAL_ENV}" != "" ]]; then
		python_virtualenv_name_with_color
		PS1+="${PYTHON_VIRTUAL_ENV_COLOR_NAME}"
	fi

	# add a space before the rest of the PS1
	if [[ "${PS1}" != "" ]] ; then
		PS1+=" "
	fi

	# Then show <last command exit code|user@hostname:path> $
	PS1+="${BLUE}<${RESET_COLOR}" # '<'

	if [ "${EXIT_CODE}" != 0 ]; then
		PS1+="${RED}${EXIT_CODE}${RESET_COLOR}" # command failed
	else
		PS1+="${LIGHT_GREEN}${EXIT_CODE}${RESET_COLOR}" # command failed
	fi
	PS1+="${BLUE}|${RESET_COLOR}" # '|'

	PS1+="${GREEN}\u${RESET_COLOR}" # the user
	PS1+="${PURPLE}@${RESET_COLOR}" # '@'
	PS1+="${LIGHT_GREEN}\H:${RESET_COLOR}" # the hostname + ':'
	PS1+="${LIGHT_BLUE}\w${RESET_COLOR}" # the working directory
	PS1+="${BLUE}>${RESET_COLOR} " # '>'
	PS1+="${YELLOW}\$ ${RESET_COLOR}" # UID 0 is '#', otherwise '$'
}
