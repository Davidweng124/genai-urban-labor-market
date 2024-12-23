# Generative Artificial Intelligence Causes Displacement for White-collar Workers but Reduces Regional Opportunity Disparities

Welcome to the repository for the paper **"Generative Artificial Intelligence Causes Displacement but Reduces Regional Opportunity Disparities"**. This repository contains all the necessary data and code used in our research, enabling reproducibility and further exploration.

## Table of Contents
- [File Description](#file-description)
- [Data Description](#data-description)
- [System Requirements](#system-requirements)
  - [Stata](#stata)
  - [Python](#python)
- [Installation Guide](#installation-guide)
  - [Stata Installation](#stata-installation)
  - [Python Installation](#python-installation)
- [Demo](#demo)
  - [Stata Demo](#stata-demo)
  - [Python Demo](#python-demo)
- [Instructions for Use](#instructions-for-use)
  - [Running Stata Scripts](#running-stata-scripts)
  - [Running Python Notebooks](#running-python-notebooks)
- [Reproduction Instructions](#reproduction-instructions)
- [License](#license)
- [Contact Information](#contact-information)

## File Description

- **`demo.do`**: Stata demo script to familiarize users with the software operations. This script does not generate any tables but ensures that Stata can run the scripts properly.
- **`table_code.do`**: Stata script used for replicating the analysis and generating all tables in the article, utilizing the provided datasets.
- **`plot.ipynb`**: Python Jupyter Notebook for generating the core figures in the paper.
- **`figure2_analysis.R`**: R code for replicating the analysis that generate Figure 2 in the paper.
- **`figure3_analysis.R`**: R code for replicating the analysis that generate Figure 3 in the paper.
- **`job_industry.dta`**: Publicly available foundational dataset containing information on job vacancies across various industries.
- **`job_industry2018-2024.dta`**: Job vacancy sample data from 2018 to 2024.
- **`job_industry2022-2024.dta`**: Job vacancy sample data from 2022 to 2024.
- **`job_city2022-2024.csv`**: City-level aggregates of job posting numbers by month and by the level of job exposure to GenAI.
- **`var_resi.csv`**: Characteristics of cities' job markets. The job diversification indices are computed from raw data provided from Zhaopin.com.

## Data Description

- **`job_industry.dta`**: This dataset serves as the foundational data for our research, providing comprehensive information on job vacancies across multiple industries. It is publicly available for researchers and interested readers.
- **`job_industry2018-2024.dta` & `job_industry2022-2024.dta`**: These datasets contain job vacancy samples spanning from 2018 to 2024 and 2022 to 2024, respectively, offering granular insights into regional job trends over time.
- **`job_city2022-2024.csv`**: This dataset provides city-level aggregates of job posting numbers by month and by the level of job exposure to GenAI (in four quartiles). The contents of the columns are as follows.  
*'city'*: Names of cities in Chinese.  
*'time'*: Year and month of the data.  
*'year'*: Year of the data.  
*'month'*: Month of the data.  
*'citycode'*: Administrative codes of cities in Chinese official administrative code system.  
*'rate_expo'*: Types of jobs by the levels of exposure to GenAI, where 1 indicates the first quartile of exposure and 4 indicates the fourth quartile of exposure.  
*'num_post'*: Number of job postings by city, month and job exposure level.  
*'tier_city'*: Tier of city as defined by the Yicai city randing. There are originally six tiers of cities. Since upper tier cities are much fewer, we merged the first-tier and emerging-first-tier cities into type-1 cities (19 in total), and the second- and third-tier cities into type-2 cities (100 in total), keeping the fourth- and fifth-tier cities as type-3 and type-4 cities (90 and 128 respectively).  
*'industry'*: Weighted seasonal output of the industries belonging to the respective job/industry exposure level in the city. Industrial outputs are from the Preliminary Estimates of Gross Domestic Product released seasonally by the National Bureau of Statistics of China.
*'expo_this_type'*: Weighted exposure index for the respective group of jobs in the respective city.
*'expo_city'*: Weight job GenAI exposure index for the whole city.  

job_industry.dta: This dataset serves as the foundational data for our research, providing comprehensive information on job vacancies across multiple industries. It is publicly available for researchers and interested readers. The contents of the columns are as follows.  
*'time'*: Year and month of the data.  
*'year'*: Year of the data.  
*'month'*: Month of the data.  
*‘position_level1’*: Name of occupational group.  
*'num_post'*: Number of job postings by city, month and job exposure level.  
*‘exposure_dwa_beta’*: GenAI exposure index of occupation.  
*‘lm_aioe_felten2023’ *: LLM exposure index developed by Felten et al. using American job content information.  
*‘industry’*: Name of the industry.  
*'industryvalue'*: Weighted seasonal output of the industries belonging to the respective job/industry exposure level in the city. Industrial outputs are from the Preliminary Estimates of Gross Domestic Product released seasonally by the National Bureau of Statistics of China.  

job_industry2018-2024.dta & job_industry2022-2024.dta: These datasets contain job vacancy samples spanning from 2018 to 2024 and 2022 to 2024, respectively, offering granular insights into regional job trends over time.The contents of the columns are as follows.  
*‘ave_education’ *: Average education at occupation level.  
*‘ave_experience’* :Average work experience at occupation level.  
*‘ave_wage’ *:Average wage at occupation level.  
In addition, variables with the same name have the same meaning as above.  


## System Requirements

### Stata

- **Version**: Stata 18.0 (MP-Parallel Edition)
- **License**: Single-user 2-core perpetual license
- **Operating Systems**: Windows, macOS, Linux
- **Non-standard Hardware**: None required

### Python (using Anaconda)

- **Version**: Python 3.8 or higher
- **Packages**:
  - pandas (≥1.3.0)
  - matplotlib (≥3.4.0)
  - numpy (≥1.21.0)
  - seaborn (≥0.11.0)
  - scipy (≥1.7.0)
  - jupyter (for running notebooks)
- **Operating Systems**: Windows, macOS, Linux
- **Non-standard Hardware**: None required

### R (using RStudio)
- **Version**: R 4.3.3 or higher, RStudio 2022.07.0 Build 548 or higher
- **Packages**:
  - dplyr (≥1.1.4)
  - lfe (≥3.0-0)
- **Operating Systems**: Windows, macOS, Linux

## Installation Guide

### Stata Installation

1. **Obtain Stata 18.0**:
   - Purchase or access Stata 18.0 through your institution.

2. **Install Stata**:
   - Follow the installation instructions provided in the [Stata Documentation](https://www.stata.com/features/documentation/).
   - For user guidance, refer to the [Stata User's Guide](https://www.stata.com/bookstore/users-guide/).

3. **Activate License**:
   - Use your single-user 2-core perpetual license to activate Stata.

**Typical Installation Time**: Approximately 15-30 minutes on a standard desktop computer.

### Python Installation

1. **Install Anaconda**:
   - Download and install [Anaconda Distribution](https://www.anaconda.com/products/distribution) suitable for your operating system.

2. **Set Up Environment**:
   - Open Anaconda Prompt (Windows) or Terminal (macOS/Linux).
   - Create a new environment:
     ```bash
     conda create -n genai_env python=3.9
     ```
   - Activate the environment:
     ```bash
     conda activate genai_env
     ```

3. **Install Required Packages**:
   ```bash
   pip install pandas matplotlib numpy seaborn scipy jupyter
## Typical Installation Time

**Typical Installation Time**: Approximately 10-20 minutes on a standard desktop computer.

## Demo

### Stata Demo

To familiarize yourself with the Stata scripts:

1. **Open Stata**.

2. **Load the Demo Script**:
    - Navigate to the repository directory.
    - Open `demo.do` in Stata.

3. **Run the Script**:
    - Execute the script to ensure that Stata can run the scripts properly.
      ```stata
      do demo.do
      ```

**Expected Output**: Confirmation that the script has run successfully without errors. No tables will be generated as `demo.do` is solely for verifying script execution.


### Python Demo

To run the Python notebook and generate the core figures:

1. **Activate Python Environment (using Anaconda)**:
    ```bash
    conda activate genai_env
    ```

2. **Navigate to Repository Directory**:
    ```bash
    cd path_to_repository
    ```

3. **Launch Jupyter Notebook**:
    ```bash
    jupyter notebook
    ```
    - Open `plot.ipynb` in the Jupyter interface.

4. **Run All Cells**:
    - Execute all cells to generate the figures.


## Instructions for Use

### Running Stata Scripts

1. **Ensure Stata 18.0 is Installed and Licensed**.

2. **Open Stata**.

3. **Load the Dataset**:
    - Use the `use` command to load `job_industry.dta` or other relevant datasets.
      ```stata
      use job_industry.dta, clear
      ```

4. **Run `table_code.do`**:
    - In Stata's command window, execute:
      ```stata
      do table_code.do
      ```
    - This will generate all tables as presented in the article.

### Running Python Notebooks

1. **Ensure Python Environment is Set Up (using Anaconda)**.

2. **Launch Jupyter Notebook**:
    ```bash
    jupyter notebook
    ```

3. **Open `plot.ipynb`**.

4. **Run All Cells**:
    - Execute all cells sequentially to generate the figures.

5. **Modify or Use Custom Data**:
    - To run the analysis on your own data, replace the datasets in the repository with your data and adjust file paths in the notebook accordingly.

## Reproduction Instructions

To reproduce all quantitative results presented in the manuscript:

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/Davidweng124/genai-urban-labor-market.git
    cd genai-urban-labor-market
    ```

2. **Set Up Stata and Python Environments**:
    - Follow the [System Requirements](#system-requirements) and [Installation Guide](#installation-guide) sections.

3. **Run Stata Scripts**:
    - Open Stata and execute `table_code.do` to generate tables.
      ```stata
      do table_code.do
      ```

4. **Run Python Notebooks**:
    - Launch `plot.ipynb` in Jupyter Notebook and run all cells to generate figures.

5. **Verify Outputs**:
    - Compare the generated tables and figures with those in the manuscript to ensure consistency.



## Contact Information

If you have any questions or need further assistance, please contact:

**Anqi Wang**  
Email: [anqiwang@stu.pku.edu.cn](mailto:anqiwang@stu.pku.edu.cn)
