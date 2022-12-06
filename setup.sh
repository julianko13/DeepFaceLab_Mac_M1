#!/usr/bin/env bash -l
is_arm64() {
  [ "$(uname -m)" == "arm64" ]
}
# Assume default profile is zsh
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }

if grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' $HOME/.zprofile 2>/dev/null;
then
    echo "Brew Already set"
else
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    #manual uninstall with this command if some problems prevents it from installing
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

if is_arm64; then
    if [[ -z "$(brew ls --versions hdf5)" ]]; then
        brew install hdf5@1.12
    fi
fi
if [[ -z "$(brew ls --versions wget)" ]]; then
    brew install wget
fi


if [ -z ${NOT_FIRST_SETUP_RUN} ]; then
    if ! command -v conda &> /dev/null
    then
        echo "conda is not installed. Installing miniconda"

        # Install conda
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh

        # Install conda
        bash Miniconda3-latest-MacOSX-arm64.sh -b -p $HOME/miniconda

        # Add conda to path
        export PATH="$HOME/miniconda/bin:$PATH"

    else
        echo "conda is installed."

    fi

    # Initialize conda
    conda init bash
    conda init zsh
    
    # Rerun the shell script with a new shell (required to apply conda environment if conda init was run for the first time)
    exec bash -c "NOT_FIRST_SETUP_RUN=1 \"$0\""
fi

export -n NOT_FIRST_SETUP_RUN
# Create conda environment
conda env create -f environment.yml

# Activate conda environment
conda activate deepfacelab

# conda should also install pip managed packages
# python -m pip install -r requirements.txt
# Remove previous git repository
rm -rf DeepFaceLab

# Clone the repo
git clone https://github.com/julianko13/DeepFaceLab.git DeepFaceLab

# Enter the repo
cd DeepfaceLab

git checkout M1_Mac_Support

conda deactivate



