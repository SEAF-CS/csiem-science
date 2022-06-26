# CSIEM-manual (csiem-science)

<!-- badges: start -->

![](https://img.shields.io/badge/book--coverage-minimal-red)[![GitHub issues](https://img.shields.io/github/issues/AquaticEcoDynamics/csiem-science)![GitHub license](https://img.shields.io/github/license/AquaticEcoDynamics/csiem-science)](https://github.com/AquaticEcoDynamics/csiem-science/issues)

<!-- badges: end -->

The goal of CSIEM-manual is to provide an easily editable "living manual" that describes the set-up and results of the The Cockburn Sound Integrated Ecosystem Model (CSIEM). The repository is a sub-module within the `CSIEM` repository available [here](https://github.com/AquaticEcoDynamics/CSIEM).

## Contributing

This manual was built using the R [bookdown](https://github.com/rstudio/bookdown) package - an extension of the [rmarkdown](https://github.com/rstudio/rmarkdown) package designed for writing long-form documents and generating outputs in multiple formats.

Below are basic instructions to help you get started editing the manual. For a detailed contribution guide, please read the [Contributing chapter](https://aquaticecodynamics.github.io/csiem-science/index.html) of the manual.

#### 1. Prerequisites

For the best experience, we recommend editing the manual using the [RStudio IDE](https://rstudio.com). Once installed, use the console to download the bookdown package:

```{r}
install.packages("bookdown")
```

#### 2. Clone the repository

Clone `CDM-manual`csiem-science\` using [GitHub Desktop](https://desktop.github.com) or from your terminal:

```{bash}
git clone https://github.com/AquaticEcoDynamics/csiem-science.git
```

#### 3. Edit a chapter

Open the R project file `CSIEM-manual.Rproj` and navigate to the `.Rmd` file that corresponds with the desired chapter you wish to edit. Once edits have been made, click the 'Build Book' button in RStudio's 'Build' tab to recompile (alternatively use the shortcut <kbd>Shift</kbd> + <kbd>CTRL</kbd> + <kbd>B</kbd> or <kbd>Shift</kbd> + <kbd>⌘</kbd> + <kbd>B</kbd>).

<img src="images/general/build_book.png" alt="Click to recompile the book!" width="438"/>

#### 4. Create a new chapter

Open the R project file `CSIEM-manual.Rproj` and create a new blank `.Rmd` file. Write it's contents and save the file as the chapter name written in 'snake case' (e.g. 'Lagoon Water Quality' becomes `lagoon_water_quality.Rmd`). Navigate to `_bookdown.yml` and add the chapter `.Rmd` file to the `rmd_files` list. Save and re-build the book.

#### 5. Push the changes

Using GitHub Desktop or your terminal, push the changes back to the csiem_science repository. Updates to the main branch will automatically trigger a re-build of the website (via Github Actions).
