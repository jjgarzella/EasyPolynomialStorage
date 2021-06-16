
module EasyPolynomialStorage

using CSV

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

end#module
