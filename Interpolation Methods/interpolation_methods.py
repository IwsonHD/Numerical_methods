from pandas import DataFrame
import numpy as np
import math as m


def get_nodes(data: DataFrame, amount: int, distrib='even') -> DataFrame:
    if distrib == 'even':
        out = [(data.iloc[ind, 0], data.iloc[ind, 1]) for ind in np.linspace(0,data.shape[0]-1, amount,dtype=int)]
    
    elif distrib == 'chebyshev':
        inds = [m.floor((data.shape[0]-1)/2 + ((data.shape[0] - 1)/2)*m.cos(k*m.pi/(amount-1))) for k in range(amount)]
        out = [(data.iloc[ind, 0], data.iloc[ind, 1]) for ind in reversed(inds)]
    elif distrib == 'random':
        inds = np.random.choice(data.shape[0], amount, replace=False).sort()
        out = [(data.iloc[ind, 0], data.iloc[ind, 1]) for ind in inds]
    return DataFrame(out,columns=None)

def lagrange_interpol(nodes:DataFrame, x_vals:list[float]) -> DataFrame:
    def lagrange_polynomial(x: float) -> float:
        out_val = 0
        n = len(nodes)

        for i in range(n):
            xi, yi = nodes.iloc[i]

            li = 1
            for j in range(n):
                if i != j:
                    xj, _ = nodes.iloc[j]
                    li *= (x-xj)/(xi - xj + np.finfo(np.float64).eps)
            out_val += li * yi
        return out_val
    interpolated_values = [(x_val, lagrange_polynomial(x_val)) for x_val in x_vals]
    return DataFrame(interpolated_values, columns=None)

#natural spline boundary condition
def splain_interpol(nodes:DataFrame, x_vals:list[float]) -> DataFrame:
    n = len(nodes) - 1  # Number of intervals
    M = np.zeros((4 * n, 4 * n))
    y_vec = np.zeros(4 * n)
    
    # y_vector evaluation
    for i in range(n):
        y_vec[2 * i] = nodes.iloc[i, 1]
        y_vec[2 * i + 1] = nodes.iloc[i + 1, 1]
    # M_matrix evaluation
    for i in range(n):
        xi = nodes.iloc[i, 0]
        xi1 = nodes.iloc[i + 1, 0]
        M[2 * i][4 * i:4 * (i + 1)] = [xi ** 3, xi ** 2, xi, 1]
        M[2 * i + 1][4 * i:4 * (i + 1)] = [xi1 ** 3, xi1 ** 2, xi1, 1]
    
    for i in range(1, n):
        xi = nodes.iloc[i, 0]
        M[2 * n - 1 + i][4 * (i - 1):4 * (i + 1)] = [3 * xi ** 2, 2 * xi, 1, 0, -3 * xi ** 2, -2 * xi, -1, 0]
    
    for i in range(1, n):
        xi = nodes.iloc[i, 0]
        M[3 * n - 2 + i][4 * (i - 1):4 * (i + 1)] = [6 * xi, 2, 0, 0, -6 * xi, -2, 0, 0]
    
    M[-2][0:2] = [6 * nodes.iloc[0, 0], 2]
    M[-1][-4:-2] = [6 * nodes.iloc[-1, 0], 2]
    
    coeffs = np.linalg.solve(M, y_vec)
    
    def eval_via_spline(x, coeffs, nodes):
        for i in range(len(nodes) - 1):
            if nodes.iloc[i, 0] <= x <= nodes.iloc[i + 1, 0]:
                a, b, c, d = coeffs[4 * i: 4 * (i + 1)]
                return a * x ** 3 + b * x ** 2 + c * x + d
        return None
    interpolated_values = [(x,eval_via_spline(x, coeffs, nodes)) for x in x_vals]
    return DataFrame(interpolated_values, columns=None)
    
            














#jescze interpolacja sklejanymi i wezly czybyszewa