import pandas as pd
from matplotlib import pyplot as plt
from interpolation_methods import * 
from collections.abc import Callable 

def plot_interpols(next_nodes:list[int], 
                  interpol_method:Callable[[DataFrame,list[float]],DataFrame],
                  distribution:str, 
                  figsize:tuple[int,int],
                  data_location:str,
                  data_name:str,
                  sep:chr,
                  save_location:str,
                  show:bool) -> None:
    
    data = pd.read_csv(data_location,sep=sep,header=None)
    for node_amount in next_nodes:
        nodes = get_nodes(data,node_amount,distrib=distribution)
        interpolated_func = interpol_method(nodes, data.iloc[:,0])
        interpolation_name = 'Cubic Spline' if interpol_method.__name__ == 'splain_interpol' else 'Lagrange'
        plt.figure(figsize=figsize)
        plt.title(f"{interpolation_name} Interpolation of {data_name} using {node_amount} nodes in {distribution} distribution")
        plt.ylabel('Height')
        plt.xlabel('Distance')
        plt.plot(data.iloc[:,0],
                 data.iloc[:,1],
                 label='Original function',
                 color='green')
        plt.plot(interpolated_func.iloc[:,0],
                 interpolated_func.iloc[:,1],
                 label='Interpolated function',
                 color='blue',
                 linestyle='--')
        plt.scatter(nodes.iloc[:,0],
                    nodes.iloc[:,1],
                    label='Nodes',
                    color='red')
        plt.legend()
        plt.savefig(save_location + f'{data_name.replace(" ","_")}_{interpolation_name.replace(" ","_")}_{distribution}_{node_amount}')
        if show:
            plt.show()
        else:
            plt.close()



def main():
    data_folder = './profile_wysokosciowe/'
    output_folder = './output_plots/'
    examined_node_amounts = [3, 6, 9, 15]

    
    plot_interpols([30],
                   lagrange_interpol,
                   'chebyshev',
                   (10,5),
                   data_folder + 'ostrowa.txt',
                   'data with numerous elevations',
                   ',',
                   output_folder,
                   True
                   )
        

    
    

if __name__ == '__main__':
    main()
