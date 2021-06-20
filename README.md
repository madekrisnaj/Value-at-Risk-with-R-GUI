# Stock-Value-at-Risk-Monte-Carlo-Simulation-

## Introduction
The Monte Carlo method is a type of algorithm that relies on random sampling from various distributions to estimate the probability or distribution of a specific outcome. It is suitable when other approaches are difficult or impossible to use, such as sensitivity analysis, option pricing, financial risk measurement, and risk management applications.

In this repository, I will show to use the built-in R function to run Monte Carlo and how to make graphical user interface to calculate value at risk with Monte Carlo Simulation.


## How Monte CarloPerforms Risk Analysis
The Monte Carlo method is performed by repeatedly running a model on a simulated outcome based on varying inputs; the inputs are uncertain and variable. A common but powerful strategy for modelling uncertainty is to randomly sample values from a probability distribution. This allows you to create thousands of input sets for your model. In this way, you can run thousands of permutations of your model, which has several benefits:

1. Your output is a large set of results. This means that you have a probability of outcomes rather than simply a single point estimate.
2. Monte Carlo generates a distribution of simulated outcomes. This makes it easy to graph and communicate findings.
3. It is easy to change the assumptions of the models by varying the distribution type or properties of the inputs.
4. You can easily model correlation between input variables.

## Required IDE for R Programming
RStudio (ver. 1.2.5042)

## Required Packagaes
