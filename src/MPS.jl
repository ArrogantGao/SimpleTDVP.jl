# in this file, I will define the Matirx Product State (MPS) class and its methods

struct MPSTensor{T, TID}
    tensor::Array{T}
    ll::Vector{TID} # left legs
    rl::Vector{TID} # right legs
    ol::Vector{TID} # open legs
end

function MPSTensor(tensor::Array{T}, ll::Vector{TID}, rl::Vector{TID}, ol::Vector{TID}) where {T, TID}
    try
        @assert length(size(tensor)) == length(ll) + length(rl) + length(ol)
    catch e
        throw("The size of the tensor does not match the number of legs")
    end

    try 
        intersection = intersect(ll, rl, ol)
        @assert length(intersection) == 0
    catch e
        throw("id of legs should not intersect with each other")
    end
    
    return MPSTensor{T, TID}(tensor, ll, rl, ol)
end

Base.show(io::IO, tensor::MPSTensor) = print(io, "MPSTensor: \n tensor: $(size(tensor.tensor)) \n ll: $(tensor.ll) \n rl: $(tensor.rl) \n ol: $(tensor.ol) \n")

struct MPS{T, TID}
    tensors::Vector{MPSTensor{T, TID}}
    raw_code::StaticEinCode{TID} 
end

