
# Predicting US Presidential Elections: A Data Analytics Project

## Overview

This project aims to predict the outcomes of presidential elections in the United States based on data from elections held between 1992 and 2020, combined with data on gun ownership, the Human Development Index (HDI), and unemployment rates. The project involves the creation and comparison of linear and polynomial regression models to determine which provides more accurate predictions.

### Contributors
- **Eng. Jakub Szczypek**
- **Eng. Michał Rola**

### Supervisors
- **Prof. Jerzy Baranowski**
- **MEng Adrian Dudek**

## Table of Contents

1. [Problem Formulation](#problem-formulation)
    - [Data Sources](#data-sources)
    - [Directed Acyclic Graph](#directed-acyclic-graph)
2. [Data Preprocessing](#data-preprocessing)
3. [Model Development](#model-development)
    - [Data Used](#data-used)
    - [Linear Regression Model](#linear-regression-model)
    - [Polynomial Regression Model](#polynomial-regression-model)
4. [Priors](#priors)
    - [Linear Regression Priors](#linear-regression-priors)
    - [Polynomial Regression Priors](#polynomial-regression-priors)
5. [Posteriors](#posteriors)
    - [Linear Regression Posteriors](#linear-regression-posteriors)
    - [Polynomial Regression Posteriors](#polynomial-regression-posteriors)
6. [Model Comparison](#model-comparison)
    - [WAIC and LOO Comparison](#waic-and-loo-comparison)
    - [Comparing Different Predictors](#comparing-different-predictors)
7. [Summary](#summary)
8. [Usage](#usage)
    - [Requirements](#requirements)
    - [Installation](#installation)
    - [Running the Project](#running-the-project)
9. [Project Structure](#project-structure)
10. [Results](#results)
11. [Contributing](#contributing)
12. [Contact](#contact)

## Problem Formulation

The project focuses on creating and comparing two models (linear and polynomial regression) to predict the results of US presidential elections using:
- Gun ownership percentage
- Human Development Index (HDI)
- Unemployment percentage

### Data Sources

1. **Presidential Elections Data**: [270towin](https://www.270towin.com/states/)
2. **Gun Ownership Data**: [RAND Corporation](https://www.rand.org/research/gun-policy/gun-ownership.html)
3. **HDI Data**: [Global Data Lab](https://globaldatalab.org/shdi/table/shdi/USA/?levels=1+4&interpolation=0&extrapolation=0)
4. **Unemployment Data**: [NCSL](https://www.ncsl.org/labor-and-employment/state-unemployment-rates)

### Directed Acyclic Graph

Predictors:
- **G**: Gun ownership percentage
- **HDI**: Human Development Index
- **U**: Unemployment percentage

Outcome:
- **V**: Voting results

Unemployment percentage is considered a confounder influencing both HDI and voting results.

## Data Preprocessing

Data from various sources were combined into a single `.xlsx` file with the following columns:
- Year
- State
- Democratic %
- Gun ownership %
- HDI
- Unemployment %

Steps:
1. Create a database file and manually enter the year and state data.
2. Transcribe the "Democratic %" data from the source.
3. Copy data for "Gun ownership %" and "HDI".
4. Calculate average unemployment rates and add to the database.

## Model Development

### Data Used

Both models utilized the same data:
- Presidential election results (1992-2020)
- Gun ownership percentage
- Human Development Index (HDI)
- Unemployment percentage

### Linear Regression Model

The linear regression model predicts election results as a linear combination of the predictors:
\[ mu = alpha + beta_G * G + beta_HDI * HDI + beta_U * U \]

### Polynomial Regression Model

The polynomial regression model includes squared terms of the predictors:
\[ mu = alpha + beta_{G1} * G + beta_{G2} * G^2 + beta_{HDI1} * HDI + beta_{HDI2} * HDI^2 + beta_{U1} * U + beta_{U2} * U^2 \]

## Priors

### Linear Regression Priors

Priors were selected based on the correlation matrix and trial and error:
- alpha ~ N(mu=47, sigma=10)
- beta_G ~ N(mu=0, sigma=0.1)
- beta_HDI ~ N(mu=0, sigma=1)
- beta_U ~ N(mu=0, sigma=0.1)
- sigma ~ N(mu=1, sigma=0.5)

### Polynomial Regression Priors

Priors for polynomial regression were more complex and involved trial and error:
- alpha ~ N(mu=47, sigma=10)
- beta_{G1} ~ N(mu=0, sigma=0.01)
- beta_{G2} ~ N(mu=0, sigma=0.001)
- beta_{HDI1} ~ N(mu=0, sigma=1)
- beta_{HDI2} ~ N(mu=0, sigma=0.1)
- beta_{U1} ~ N(mu=0, sigma=0.01)
- beta_{U2} ~ N(mu=0, sigma=0.001)
- sigma ~ N(mu=1, sigma=0.5)
## Posteriors

### Linear Regression Posteriors

Posterior distributions were concentrated with low standard deviations, and the model accurately represented the data with minor fluctuations.

### Polynomial Regression Posteriors

Similar to the linear model, but with more precise parameters for squared terms, indicating sensitivity to small changes in predictors.

## Model Comparison

### WAIC and LOO Comparison

- Linear regression model performed better than polynomial regression model based on WAIC and LOO criteria.
- Linear model was more stable and easier to implement.

### Comparing Different Predictors

- Linear model with two predictors (HDI and gun ownership) performed almost as well as the three-predictor model.
- Polynomial model performed adequately with HDI and gun ownership, with no significant improvement from adding unemployment percentage.

## Summary

Predicting US presidential elections was a challenging but insightful project. Contrary to expectations, the linear regression model outperformed the polynomial regression model, likely due to its stability and better handling of data without extreme fluctuations. Future work could explore more complex models or different predictors to improve accuracy further.

## Usage

### Requirements

- Python 3.8 or higher
- Jupyter Notebook
- Pandas
- NumPy
- SciPy
- Statsmodels
- Matplotlib

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/SzczypekJ/Predicting-USA-presidential-elections.git
    cd Predicting-USA-presidential-elections
    ```

2. Create and activate a virtual environment:
    ```sh
    python3 -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scriptsctivate`
    ```

3. Install the required packages:
    ```sh
    pip install -r requirements.txt
    ```

### Running the Project

Open the Jupyter Notebook:
```sh
jupyter notebook first_model.ipynb
```

## Project Structure

- **first_model.ipynb**: Jupyter Notebook containing the code for data preprocessing, model creation, and analysis.
- **getting_unemployement_data.ipynb**: Jupyter Notebook containing the code for data preprocessing.
- **data/**: Directory containing the data files used in the project.
- **.stan files**: Stan files containing the linear or polynomial model.

## Results

Results and plots generated during the analysis can be found in the first_model.ipynb file or in the Final_report.pdf report.

## Contributing

Contributions are welcome! Please create a pull request with a detailed description of your changes.

## Contact

For any questions or support, please contact jakub.szczypek@tlen.pl.
