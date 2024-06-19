# Image Airlight Estimation Script

This script processes images in a specified directory to estimate the airlight using internal patch recurrence. The estimated airlight values are then saved in both text and CSV formats.

## Prerequisites

- MATLAB
- Image Processing Toolbox

## Setup

1. Place your images in subfolders within the `data` directory.
2. Ensure that the `AirlightUsingPatchRecurrence` function is available in your MATLAB path.

## Usage

1. Copy the script into a new `.m` file in your MATLAB workspace.
2. Run the script.

The script will perform the following steps:

1. Clear all variables and close all figures.
2. Set the base directory for images (`data`) and the directory to save processed images (`processed`).
3. Retrieve a list of all subfolders within the base directory.
4. Initialize an empty array to store image file paths.
5. Loop through each subfolder, retrieve all images with `.jpg`, `.jpeg`, and `.png` extensions, and store their file paths.
6. Process each image in parallel to:
   - Read the image.
   - Estimate the airlight using the `AirlightUsingPatchRecurrence` function.
   - Construct the save folder path within the `processed` directory.
   - Save the estimated airlight values as both text and CSV files in the respective subfolder within `processed`.

## File Structure

### Input Directory Structure (`data`)

data/
│
├── folder1/
│ ├── image1.jpg
│ ├── image2.png
│ └── ...
│
├── folder2/
│ ├── image3.jpg
│ ├── image4.png
│ └── ...
│
└── ...


### Output Directory Structure (`processed`)

processed/
│
├── folder1/
│ ├── image1_estimatedAirlight.txt
│ ├── image1_estimatedAirlight.csv
│ ├── image2_estimatedAirlight.txt
│ ├── image2_estimatedAirlight.csv
│ └── ...
│
├── folder2/
│ ├── image3_estimatedAirlight.txt
│ ├── image3_estimatedAirlight.csv
│ ├── image4_estimatedAirlight.txt
│ ├── image4_estimatedAirlight.csv
│ └── ...
│
└── ...


## Notes

- Ensure that the `data` directory exists and contains subfolders with images.
- The script uses `parfor` for parallel processing; ensure you have the Parallel Computing Toolbox installed.
- Modify `baseDir` and `processedBaseDir` variables if your directory structure differs.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
