import pandas as pd
from matplotlib import pyplot as plt

GS_res_norms = pd.read_csv('following_residuals_Gauss_Seidel.txt')
J_res_norms = pd.read_csv('following_residuals_Jacobi.txt')
GS_res_norms_C = pd.read_csv('following_residuals_Gauss_Seidel_C.txt')
J_res_norms_C = pd.read_csv('following_residuals_Jacobi_C.txt')

J_times = pd.read_csv('times_Jacobi_F.txt', sep=' ')
GS_times = pd.read_csv('times_Gauss_Seidel_F.txt',sep=' ')
direct_LU_times = pd.read_csv('times_direct_LU_F.txt',sep=' ')


plt.figure(figsize=(14,7))
plt.title("Following residuals for Jacobi and Gauss-Seidel (task B)")
plt.yscale("log")
plt.ylabel("Euclidean norm of residual")
plt.xlabel("Iteration")
plt.plot(GS_res_norms, label='Gauss-Seidel residual norms',color='red')
plt.plot(J_res_norms, label='Jacobi residual norms', color='blue')
plt.legend()
plt.savefig("residuals_Jacobi_Gauss-Seidel_taskB.png")
plt.show()


plt.figure(figsize=(14,7))
plt.title("Following residuals for Jacobi and Gauss-Seidel (task C)")
plt.yscale("log")
plt.ylabel("Euclidean norm of residual")
plt.xlabel("Iteration")
plt.plot(GS_res_norms_C, label='Gauss-Seidel residual norms',color='red')
plt.plot(J_res_norms_C, label='Jacobi residual norms', color='blue')
plt.legend()
plt.savefig("residuals_Jacobi_Gauss-Seidel_taskC.png")
plt.show()

plt.figure(figsize=(14,7))
plt.title("Times of solving for n-sized matrixes")
plt.ylabel("Time")
plt.xlabel("Matrix size")
plt.yscale('log')
plt.plot(J_times['size'],J_times['time'], label='Jacobitime', color='blue')
plt.plot(GS_times['size'], GS_times['time'], label='Gauss-Seidel', color='red')
plt.plot(direct_LU_times['size'], direct_LU_times['time'],label='direct LU decomposition', color='green')
plt.legend()
plt.savefig("timeOfSolving.png")
plt.show()