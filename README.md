# Poll_accuracy

Project implemented in Python to simulate and make "prediction" about the 2016 presidential election.(well, 3 months after the election). The idea is very simple: assuming that the outcome of the presidential race <b> at each state </b> follows a Bernalloui distribution where Donald Trump (now president-elect) has the probability of winning <b><i> p </i></b>, we can iterate the race in each state over a large amount of time and compute the mean electoral votes.

The question is: how do we find <b><i>p</i></b>?

Two methods are used:
* Regression based on Washington Post pre-election poll (adjusted by the 2012 biased)
* Bayesian inference with Metropolis-Hasting algorithm

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Project uses Python and many relevant statistical, graphical libaries, notably:
* panda
* numpy
* matplotlib

Information on how to install these packages can be found only. I highly recommend using Anaconda platform.
```
conda install pandas
```
R is used for Bayesian simulation, mainly due to its computational prowess. I will soon update a code in Python.

### Running:

There are two ways you can view/run/test the projects:

1. Jupyter notebook (recommended):

I prefer using Jupyter notebook as it retains the logical flow of the code and the way I broke the projects down into smaller problems. 
Very simple use, just run ```notebook.ipynb``` cell by cell. At some point, you will have to start using R ```Bayesian_MCMC.R```to conduct Bayesian MCMC.

<i>I will soon add a detailed discussion on the results of the projects.</i>


2. Classic Python files:

<i>I will soon update the repository with  ```application.py``` and ```helpers.py```. </i>

The project allows you to run a simulation of 10,000 election races and present data in a nice histogram and a choropleth map

* A nice histogram that presents results from 10,000 simulation:
![picture alt](https://github.com/tuangauss/poll_accuracy/blob/master/demo%20histogram.JPG?raw=true)

* A chloropth math that presents probability of Trump winning in each state:
![picture alt](https://github.com/tuangauss/poll_accuracy/blob/master/demo%20choropleth%20map.JPG?raw=true)

## Authors

* **Tuan Nguyen Doan** - *Initial work* - [tuangauss](https://github.com/tuangauss)

This is a self-learning project and I hope to learn from the expertise of the community. Please reach out to me if you have any suggestion or ideas.


## Acknowledgments
This is a self-learning project and I am proud to present the following sources as my reference (and inspiration):
* Harvard Open Course CS109: Data Science (the idea of this project comes from one of the problem sets)
* Open-resourced code: for choropleth math, basic question, run_time issues
* Yale Stat 238
* Five-thirty eight
* Open poll data from [here](https://www.r-bloggers.com/fivethirtyeights-polling-data-for-the-us-presidential-election/)

