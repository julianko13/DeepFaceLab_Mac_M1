## Intro

This project provides scripts inspired by
    [DeepFaceLab_MacOS]https://github.com/chychkan/DeepFaceLab_MacOS.git [DeepFaceLab_Linux](https://github.com/lbfs/DeepFaceLab_Linux) to setup and run [DeepFaceLab](https://github.com/iperov/DeepFaceLab) on MacOS.

You'll need `brew`, `git`, `ffmpeg`,`conda` available to be able to execute these scripts. The scripts will create a virtual env sandbox and will install all necessary dependencies there, so your main installation of `python3` will be left intact.

## NOTE: Apple M1 chip

Currently there's limited support for Apple M1 laptops. You can do model training, but the XSeg editor currently does not work (the DeepFaceLab codebase is not compatible with PyQt6).

## Setup

**Tools**

For **Apple M1** laptops you also need [hdf5](https://formulae.brew.sh/formula/hdf5) lib installed.
Check if you have it with `brew ls --versions hdf5`. Install it with `brew install hdf5`.
Current version must match h5py or an error will raise.
`brew install hdf5@1.12`

brew can be install in macOS terminal by this command:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

**Clone and setup**

1. Clone this repository (`git clone https://github.com/chychkan/DeepFaceLab_MacOS.git`)
2. Run script `./scripts/0_setup.sh` to get [DeepFaceLab](https://github.com/iperov/DeepFaceLab), create virtual env and install necessary Python dependencies. This may take several minutes to run.

Now you can put your `data_src.mp4` and `data_dst.mp4` files into the `workspace/` dir and start running scripts from the `scripts/` dir.

## Tutorials and docs

See [DeepFaceLab](https://github.com/iperov/DeepFaceLab) project for links to guides and tutorials.
