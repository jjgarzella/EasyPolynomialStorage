
import csv

def read_d1polys(filename,x,process_coef=eval):
    """
        read_d1polys(filename,x,process_coef=eval)


        Example:
        sage: Qz3.<z3> = NumberField(x^2 + x + 1)                                       
        sage: Qz3x.<x> = Qz3['x']
        read_d1polys("testcyclos",x)

    """
    Fx = parent(x)
    polys = []
    with open(filename + '.d1polys', 'r') as file:
        for row in csv.reader(file):
            coefs = [process_coef(c) for c in row]
            polys.append(Fx(coefs))
    return polys 
    
