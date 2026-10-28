// =====================================================================
// DAPI nuclei count and FIS1 puncta quantification
// Tested with: Fiji/ImageJ 1.54 (indicate your version)
// Input: RGB image, blue = DAPI, green = FIS1
// Output: nuclei count, FIS1 puncta count, puncta per nucleus (Log)
// =====================================================================

// ---------------------------- Parameters -----------------------------
roiX = 390;                  // ROI top-left corner (pixels)
roiY = 290;
roiW = 500;                  // ROI width and height (pixels)
roiH = 500;

dapiThresholdMethod = "Triangle dark";
minNucleusSize = 75;         // minimum nucleus area (pixels^2)

rollingBall = 50;            // FIS1 background subtraction radius (pixels)
gaussSigma = 0.5;            // FIS1 Gaussian blur sigma (pixels)
prominence = 7;              // FIS1 Find Maxima prominence (noise tolerance)

interactive = false;         // true = pause to visually check each step
// ---------------------------------------------------------------------

setOption("BlackBackground", false);
original = getTitle();

// Crop ROI and split channels
makeRectangle(roiX, roiY, roiW, roiH);
run("Duplicate...", "title=ROI");
run("Split Channels");

// ------------------------------ DAPI ---------------------------------
selectWindow("ROI (blue)");
setAutoThreshold(dapiThresholdMethod);
if (interactive) {
    run("Threshold...");
    waitForUser("Check threshold, then click OK.");
}
run("Make Binary");
run("Fill Holes");
run("Watershed");
if (interactive) waitForUser("Check watershed separation, then click OK.");

run("Clear Results");
run("Analyze Particles...", "size=" + minNucleusSize + "-Infinity display clear pixel");
nuclei = nResults;

// ------------------------------ FIS1 ---------------------------------
selectWindow("ROI (green)");
run("Subtract Background...", "rolling=" + rollingBall);
run("Gaussian Blur...", "sigma=" + gaussSigma);

run("Clear Results");
run("Find Maxima...", "prominence=" + prominence + " output=Count");
fis1 = getResult("Count", nResults - 1);

// ----------------------------- Results -------------------------------
if (nuclei > 0) ratio = fis1 / nuclei;
else ratio = NaN;

print("Image: " + original);
print("Nuclei: " + nuclei);
print("FIS1 puncta: " + fis1);
print("FIS1 puncta per nucleus: " + ratio);
print("----------------------------------------");

// ------------------------------ Cleanup ------------------------------
close("ROI (*)");