# import necessary package
import numpy as np


# define a function that takes the predicted data from a given growth rate, and the observed data to evaluate quality
# of the fit
def squared_error(prediction: np.array, data: np.array) -> float:
    # the difference between our prediction and date
    residual = np.array([prediction[i] - data[i] for i in range(len(data))])
    # use the residual to calculate the mean squared error
    mse = np.sum(residual**2)/len(data)
    return mse


if __name__ == '__main__':
    # Part 1:
    # Set the initial population N0 and the growth rate
    N0, rate = 100, 0.4
    # generate the t array of time points from 0 to 10 seconds, in 0.2 second increments
    t = np.arange(0, 10.2, 0.2)
    # calculate the population of the colony at the time points in t and store the result in population_size
    population_size = np.array([N0 * np.exp(i * rate) for i in t])
    # print the population_size
    print('the population size is:\n', population_size, '\n')
    # calculate the noise
    noise = np.random.normal(0, 250, len(population_size))
    # create population_size_noise by adding the noise to the population at each time point
    population_size_noise = population_size + noise
    # print the population_size_noise
    print('the population noise size is:\n', population_size_noise, '\n')

    # Part 2:
    # define range_rate by a range of parameters from 0.1, up to and including 1, of step size 0.1
    range_rate = np.arange(0.1, 1.1, 0.1)
    # initialize a list to store our results
    mse = []
    for rate in range_rate:
        # get different prediction based on different rate
        prediction = np.array([N0 * np.exp(i * rate) for i in t])
        # calculate the error between prediction and actual data by calling squared_error function
        error = squared_error(prediction, population_size_noise)
        mse.append(error)

    # find the index of the minimum value in mse
    idx_min_mse = mse.index(min(mse))
    # use the index of the min value in mse to obtain the corresponding rate
    # remember the arrays are the same size, and generated in order when iterating over range_rates
    best_fit = range_rate[idx_min_mse]
    # print the best_fit range
    print('We predict the rate of growth of this bacterial population to be', best_fit)
