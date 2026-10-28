# FIS1 Puncta Quantification Using Fiji/ImageJ

## Overview

This repository contains a custom Fiji/ImageJ macro for quantifying FIS1 fluorescence puncta relative to the number of DAPI-positive nuclei within a predefined region of interest (ROI).

The macro reports:
- Number of nuclei detected.
- Number of FIS1 intensity maxima detected.
- Number of FIS1 puncta per nucleus.

**Note:** FIS1 puncta density is an image-based measurement and should not be interpreted as a direct measure of mitochondrial fission, mitochondrial dynamics, or mitophagy.

## Requirements

- Fiji (ImageJ), version 1.54p.
- RGB fluorescence images with DAPI in the blue channel and FIS1 in the green channel.
- Images acquired using a 20× objective.

All images were acquired under the same imaging conditions to ensure consistency across samples.

## Method

The macro performs the following steps:

1. Selects and duplicates a predefined region of interest (ROI).
2. Splits the image into its color channels.
3. Processes the DAPI channel using automatic thresholding, binary conversion, hole filling, and watershed segmentation.
4. Counts nuclei using the *Analyze Particles* function.
5. Processes the FIS1 channel using rolling-ball background subtraction and Gaussian blurring.
6. Detects local intensity maxima in the FIS1 channel using the *Find Maxima* function.
7. Calculates FIS1 puncta per nucleus by dividing the number of detected FIS1 maxima by the number of detected nuclei.

## Parameters

The following parameters are defined in the macro and can be adjusted when appropriate:

| Parameter | Default value | Description |
|---|---:|---|
| `roiX` | 390 | ROI horizontal starting coordinate (pixels) |
| `roiY` | 290 | ROI vertical starting coordinate (pixels) |
| `roiW` | 500 | ROI width (pixels) |
| `roiH` | 500 | ROI height (pixels) |
| `dapiThresholdMethod` | `Triangle dark` | Automatic thresholding method for DAPI |
| `minNucleusSize` | 75 | Minimum particle area for nuclear counting (pixels²) |
| `rollingBall` | 50 | Rolling-ball radius for FIS1 background subtraction (pixels) |
| `gaussSigma` | 0.5 | Gaussian blur sigma for FIS1 (pixels) |
| `prominence` | 7 | Prominence parameter for FIS1 local-maxima detection |
| `interactive` | `false` | Enables interactive visual checks when set to `true` |

## Usage

1. Open the RGB fluorescence image in Fiji/ImageJ.
2. Open the macro file, `FIS1_puncta_quantification.ijm`.
3. Check that the ROI coordinates and analysis parameters are appropriate for the image.
4. Run the macro.
5. Record the number of detected nuclei, the number of FIS1 intensity maxima, and the resulting FIS1 puncta-per-nucleus value displayed in the Fiji/ImageJ Log window.

Use consistent ROI placement and analysis parameters across experimental groups. Inspect representative images to verify that nuclei and FIS1 maxima are detected appropriately.

## Software

The macro was tested using Fiji/ImageJ version 1.54p.

## Repository contents

- `FIS1_puncta_quantification.ijm`: Fiji/ImageJ macro.
- `README.md`: Documentation and usage instructions.

## Citation

If you use this macro, please cite this repository and the associated publication, when available.

Repository: https://github.com/ArantxaGM/FIS1-puncta-quantification.git
