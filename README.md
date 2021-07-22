# EasyPolynomialStorage

This is a lightweight library which defines a few file types which are designed
to store polynomials on disk.

The goal of this library is to make it easy for Pure Mathematics researchers to 
switch data between computer algebra systems.
In particular, no effort is made to be efficient or generic.

Pull requests are welcome.

# File Types

We define two file formats

* `.d1polys`, a list of dense 1-variable polynomials,
  is a (zero-indexed) csv file where the (i,j)th coordinate in the file
  is the coefficient of `x^j` for the ith polynomial in the list
* `.d2poly`, a single dense 2-variable polynomial,
  is a (zero-indexed) csv file where the (i,j)th coordinate in the file
  is the coefficient of `x^i y^j`. 
* `.sMVpoly`, a single sparse multi-variable polynomial
  is a json array of monomials
  ```
  [{ "coef" : 2,
     "vars" : [0, 2, 1, 1]
   },
   { "coef" : 1,
     "vars" : [1, 1, 0, 0]
   }]
  ```
  so that the ith entry of the array indicates the exponent of `x_i` in the monomial

Note:
if you didn't catch it, the "d" in the file type names stands for dense and s for sparse

# Usage

The code in this repository provides a variety of `write_*` and `read_*` methods
for different computer algebra systems. 

We recommend using this code in one of two ways:
1. Copy the read/write methods that you need into your own project as necessary
2. Include this repository as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
   in your project.

Option #1 is quick and dirty, 
while option #2 is more sustainable 
(e.g. you can get updates, 
contribute back any improvements you make) 
but requires you to be using a git repository.

Enjoy!
