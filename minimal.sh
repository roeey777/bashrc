#! /bin/bash

# this file should be sourced *only* after colors.sh was sourced
# since it uses functions from colors.sh (to show conda env, python virtualenv & git branch name)

PROMPT_COMMAND=__minimal_ps1
function __minimal_ps1() {
    local EXIT_CODE="$?" # must be first so it will save the *last* executed command exit code.
    PS1=""

    # First show the conda environment, if any
    if [[ "${CONDA_PREFIX}" != "" ]]; then
        conda_env_name_with_color # function from colors.sh
        PS1+="${CONDA_ENV_NAME_WITH_COLOR}"
    fi

    # At second show python virtualenv name, if any
    if [[ "${VIRTUAL_ENV}" != "" ]]; then
        python_virtualenv_name_with_color # function from colors.sh
        PS1+="${PYTHON_VIRTUAL_ENV_COLOR_NAME}"
    fi

    git_branch_with_color
    PS1+="${GIT_BRANCH_NAME_WITH_COLOR}"

    # add a space before the rest of the PS1
    if [[ "${PS1}" != "" ]]; then
        PS1+=" "
    fi

    PS1+="${YELLOW}\$ ${RESET_COLOR}" # UID 0 is '#', otherwise '$'
}
