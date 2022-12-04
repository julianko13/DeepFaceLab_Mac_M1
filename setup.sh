#!/usr/bin/env bash -l
is_arm64() {
  [ "$(uname -m)" == "arm64" ]
}

command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";}

if is_arm64; then
    if [[ -z "$(brew ls --versions hdf5)" ]]; then
        brew install hdf5@1.12.2
    exit 1
    fi
fi


if [ -z ${NOT_FIRST_SDSETUP_RUN} ]; then
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
    conda init

    # Rerun the shell script with a new shell (required to apply conda environment if conda init was run for the first time)
    exec bash -c "NOT_FIRST_SETUP_RUN=1 \"$0\""
fi

export -n NOT_FIRST_SDSETUP_RUN
# Create conda environment
conda env create -f environment.yml

# Activate conda environment
conda activate deepfacelab

python -m pip install
# Remove previous git repository
rm -rf DeepFaceLab

# Clone the repo
git clone https://github.com/julianko13/DeepFaceLab.git DeepFaceLab

# Enter the repo
cd DeepfaceLab

git checkout M1_Mac_Support

if [[ -z "$(brew ls --versions hdf5)" ]]; then
    echo "ERROR: HDF5 needs to be installed to run DeepFaceLab on M1 chip."
    echo "You can install it with 'brew install hdf5'. For more details, see https://formulae.brew.sh/formula/hdf5"
    echo "Once it is installed, run ./scripts/0_setup.sh again"
    exit 1
fi
conda deactivate



