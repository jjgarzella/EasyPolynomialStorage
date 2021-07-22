
module EasyPolynomialStorage

using CSV
import JSON.parsefile

using Polynomials
using Oscar

export write_d1polys

function write_d1polys(filename,poly_arr::Vector{<:AbstractPolynomial})
  c_arrs = Polynomials.coeffs.(poly_arr)
  write_d1polys_helper(filename,c_arrs)
end

function write_d1polys(filename,poly_arr::Vector{<:RingElem})
  c_arrs = @. collect(coefficients(poly_arr))
  write_d1polys_helper(filename,c_arrs)
end

"""
    write_d1polys_helper(filename,coeffs_arrays)

This method does work that is common to writing a d1polys file
whatever julia format the polynomial takes.
"""
function write_d1polys_helper(filename,coeffs_arrays)
  maxLen = maximum(length.(coeffs_arrays))
  for cs in coeffs_arrays
    append!(cs,zeros(Int, maxLen-length(cs)))
  end
  output = hcat(coeffs_arrays...) |> transpose |> CSV.Tables.table                          
  output |> CSV.write("$filename.d1polys", header=false) 
  # ^^ this was being a bit weird for me with "header=false" vs. "writeheader=false"
  #   but it seems like it's better now.
end

export read_sMVpoly

"""
   eval_string(s)

Evaluates the string `s` as code.

Note: this does not protect against injection attacks.
I hope nobody would ever use this code in a security-
critical context.
"""
eval_string(s::String) = eval(Meta.parse(s))

"""
    read_sMVpoly(filename,xs,process_coef=eval_string)

Reads the file `filename.sMVpoly` as a polynomial.
The type of polynomial is determined by the variables,
which are stored in the array `xs`. 
If the coefficients of the polynomial require special processing,
e.g. the coefficients are over a number field,
then you can pass a "callback-style" function `process_coef`.
The default is to just eval the coefficients as julia code,
which should be sufficient over ZZ/QQ/RR.

# Examples
    Qx, x = PolynomialRing(QQ, "x")
    Qa, a = NumberField(x^2 + 15, "a")
    Qay, y = PolynomialRing(Qa, "y" => 1:6)

    function process_coef(c)
      d = replace(c, "(" => "")
      e = replace(d, " I) Sqrt[15]" => "*a")
      eval(Meta.parse(e))
    end

    read_sMVpoly("testpoly",y,process_coef)
"""
function read_sMVpoly(filename,xs,process_coef=eval_string)
  jsondict = parsefile(filename * ".sMVpoly")
  f = zero(xs[1])
  for monomial in jsondict
    coef = process_coef(monomial["coef"])
    vs = monomial["vars"]
    f += coef * prod([xs[i]^vs[i] for i in 1:length(vs)])
  end
  f
end

end#module
