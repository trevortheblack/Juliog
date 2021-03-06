# TODO create equivalence, greater, lesser, greterequal, lesserequal
# TODO create add, subtract, mult, divide, rem functions

WireVal = Union{UInt, UInt8, Array{UInt8}}


function CONST(OUT::Wire, val::WireVal, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _CONST_arith(val)
    OUT.val[] = f()
    cnst = Block(Array{Wire}(0), [OUT], f, delays)
end
function EQUALS(OUT::Wire, A::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _EQUALS_arith(A)
    eqls = Block([A], [OUT], f, delays)
    push!(A.Dependent, eqls)
end
function BIT(OUT::Wire, A::Wire, index::Int, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _BIT_arith(A, index)
    bit = Block([A], [OUT], f, delays)
    push!(A.Dependents, bit)
end
function BITS(OUT::Wire, A::Wire, bitEnd::Int, bitStart::Int, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _BITS_arith(A, bitEnd, bitStart)
    bts = Block([A], [OUT], f, delays)
    push!(A.Dependents, bts)
end
function REPEAT(OUT::Wire, A::Wire, repeatCount::Int, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _REPEAT_arith(A, repeatCount)
    rept = Block([A], [OUT], f, delays)
    push!(A.Dependents, rept)
end
function CAT(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _CAT_arith(A, B)
    ct = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, ct)
    push!(B.Dependents, ct) 
end
function AND(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _AND_arith(A, B)
    and = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, and)
    push!(B.Dependents, and)
end
function OR(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _OR_arith(A, B)
    or = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, or)
    push!(B.Dependents, or)
end
function NOT(OUT::Wire, A::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _NOT_arith(A)
    not = Block([A], [OUT], f, delays)
    push!(A.Dependents, not)
end
function XOR(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _XOR_arith(A, B)
    xorr = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, xorr)
    push!(B.Dependents, xorr)
end
function ADD(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _ADD_arith(A, B)
    add = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, add)
    push!(B.Dependents, add)
end
function SUB(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _SUB_arith(A, B)
    subt = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, subt)
    push!(B.Dependents, subt)
end
function MULT(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _MULT_arith(A, B)
    mult = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, mult)
    push!(B.Dependents, mult)
end
function DIV(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _DIV_arith(A, B)
    divd = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, divd)
    push!(B.Dependents, divd)
end
function REM(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _REM_arith(A, B)
    remn = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, remn)
    push!(B.Dependents, remn)
end
function EQUIVALENCE(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _EQUIVALENCE_arith(A, B)
    equ = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, equ)
    push!(B.Dependents, equ)
end
function GREATER(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _GREATER_arith(A, B)
    grt = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, grt)
    push!(B.Dependents, grt)
end
function GREATEREQUAL(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _GREATEREQUAL_arith(A, B)
    ge = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, ge)
    push!(B.Dependents, ge)
end
function LESSER(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _LESSER_arith(A, B)
    lsr = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, lsr)
    push!(B.Dependents, lsr)
end
function LESSEREQUAL(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _LESSEREQUAL_arith(A, B)
    le = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, le)
    push!(B.Dependents, le)
end
function MUX(OUT::Wire, C::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _MUX_arith(C, A, B)
    mux = Block([C ; A ; B], [OUT], f, delays)
    push!(C.Dependents, mux)
    push!(A.Dependents, mux)
    push!(B.Dependents, mux)
end
function LATCH(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _LATCH_arith(OUT, A, B)
    latch = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, latch)
    push!(B.Dependents, latch)   
end

function _CONST_arith(val::UInt)
    return () -> begin
        val
    end
end
function _CONST_arith(val::UInt8)
    return () -> begin
        val
    end
end
function _CONST_arith(val::Array{UInt8})
    return () -> begin
        val
    end
end

function _EQUALS_arith(A::Wire)
    return () -> begin
        return A.val[]
    end
end

function _BIT_arith(A::Wire, index::Int)
    return () -> begin
        __BIT_arith(A.val[], index)
    end
end
function __BIT_arith(val::Array{UInt8}, index::Int)
    return val[index]
end
function __BIT_arith(val::UInt8, index::Int)
    return val
end
function __BIT_arith(val::UInt, index::Int)
    val = val << (63 - index)
    val >> 63
    return val
end

function _BITS_arith(A::Wire, bitEnd::Int, bitStart::Int)
    return () -> begin
        __BITS_arith(A.val[], bitEnd, bitStart)
    end
end
function __BITS_arith(val::Array{UInt8}, bitEnd::Int, bit_Start::Int)
    return val[(bitStart+1):(bitEnd+1)]
end
function __BITS_arith(val::UInt8, bitEnd::Int, bitStart::Int)
    return val
end
function __BITS_arith(val::UInt, bitEnd::Int, bitStart::Int)
    shift = 63 - bitEnd
    val = val << shift
    val >> (shift + bitStart)
end

function _REPEAT_arith(A::Wire, repeatCount::Int)
    return () -> begin
        __REPEAT_arith(A.val[], UInt(a.BitCount), UInt(repeatCount))
    end
end
function __REPEAT_arith(a_val::UInt, bitCount::UInt, repeatCount::UInt)
    if (bitCount * repeatCount) <= 64
        out = a_val
        for i = 2:repeatCount
            out = (out << bitCount) | a_val
        end
        return out
    else
        a_array = zeros(UInt8, a_bit_c)
        Base.digits!(a_array, a_val, 2) 
        out_array = a_array
        for i = 1:repeatCount
            out_array = [out_array ; a_array]
        end
        return out_array
    end
end
function __REPEAT_arith(a_val::UInt8, bitCount::UInt, repeatCount::UInt)
    out = Array{UInt8}(repeatCount)
    for i = 1:repeatCount
        out[i] = a_val
    end
    return out
end
function __REPEAT_arith(a_val::Array{UInt8}, bitCount::UInt, repeatCount::UInt)
    out = Array{UInt8}(bitCount * repeatCount)
    for i = 1:repeatCount
        out[( ((i-1)*bitCount) + 1):( (i)*bitCount )] = a_val
    end
    return out
end

function _CAT_arith(A::Wire, B::Wire)
    return () -> begin
       __CAT_arith(a.val[], b.val[], a.BitCount, b.BitCount) 
    end
end
function __CAT_arith(a_val::UInt, b_val::UInt, a_bit_c::Int, b_bit_c::Int)
    if (a_bit_c + b_bit_c) <= 64
        return UInt((a_val << b_bit_c) | b_val)
    else
        a_array = zeros(UInt8, a_bit_c)
        b_array = zeros(UInt8, b_bit_c)
        Base.digits!(a_array, a_val, 2) 
        Base.digits!(b_array, b_val, 2)
        return [a_array ; b_array]
    end
end
function __CAT_arith(a_val::UInt, b_val::UInt8, a_bit_c::Int, b_bit_c::Int)
    a_array = zeros(UInt8, a_bit_c)
    Base.digits!(a_array, a_val, 2)    
    return [a_array ; b_val]
end
function __CAT_arith(a_val::UInt, b_val::Array{UInt8}, b_bit_c::Int)
    a_array = zeros(UInt8, a_bit_c)
    Base.digits!(a_array, a_val, 2) 
    return [a_array ; b_val]
end
function __CAT_arith(a_val::UInt, b_val::Array{UInt8}, b_bit_c::Int)
    a_array = zeros(UInt8, a_bit_c)
    Base.digits!(a_array, a_val, 2) 
    return [a_array ; b_val]
end
function __CAT_arith(a_val::UInt8, b_val::UInt, a_bit_c::Int, b_bit_c::Int)
    b_array = zeros(UInt8, b_bit_c)
    Base.digits!(b_array, b_val, 2)
    return [a_val ; b_array]
end
function __CAT_arith(a_val::UInt8, b_val::UInt8, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end
function __CAT_arith(a_val::UInt8, b_val::Array{UInt8}, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end
function __CAT_arith(a_val::Array{UInt8}, b_val::UInt, a_bit_c::Int, b_bit_c::Int)
    b_array = zeros(UInt8, b_bit_c)
    Base.digits!(b_array, b_val, 2)
    return [a_val ; b_array]    
end
function __CAT_arith(a_val::Array{UInt8}, b_val::UInt8, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end
function __CAT_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end

function _AND_arith(A::Wire, B::Wire)
    return () -> begin
        __AND_arith(A.val[] , B.val[], A.BitCount)
    end
end
function __AND_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    return a_val & b_val
end
function __AND_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == 0x0 || b_val == 0x1
        return UInt8(a_val) & b_val
    end
    return (a_val == 0x0) ? 0x0 : UInt8('x')    
end
function __AND_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = a_val
    for i = 1:bitCount
        b = b_val[i]
        if b == 0x0 || b == 0x1
            out_array[i] = UInt8(tmp & b)
        else
            out_array[i] = ((tmp & 0x1) == 0x0) ? 0x0 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __AND_arith(a_val::UInt8, b_val::UInt, bitCount::Int)
    if a_val == 0x0 || a_val == 0x1
        return a_val & UInt8(b_val)
    end
    return (b_val == 0x0) ? 0x0 : UInt8('x')
end
function __AND_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)
    if     a_val == 0x0 || b_val == 0x0
        return 0x0
    elseif a_val == 0x1 && b_val == 0x1
        return 0x1
    else
        return UInt8('x')
    end 
end
function __AND_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if     a_val == 0x0 || b_val[] == 0x0
        return 0x0
    elseif a_val == 0x1 && b_val[] == 0x1
        return 0x1
    else
        return UInt8('x')
    end
end
function __AND_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = b_val
    for i = 1:bitCount
        a = a_val[i]
        if a == 0x0 || a == 0x1
            out_array[i] = UInt8(tmp & a)
        else
            out_array[i] = ((tmp & 0x1) == 0x0) ? 0x0 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __AND_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if     a_val[] == 0x0 || b_val == 0x0
        return 0x0
    elseif a_val[] == 0x1 && b_val == 0x1
        return 0x1
    else
        return UInt8('x')
    end
end
function __AND_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:bitCount
        if     a_val[i] == 0x0 || b_val[i] == 0x0
            out_array[i] = UInt8(0)
        elseif a_val[i] == 0x1 && b_val[i] == 0x1
            out_array[i] = UInt8(1)
        else
            out_array[i] = 'x'
        end
    end
    return out_array
end

function _OR_arith(A::Wire, B::Wire)
    return () -> begin
        __OR_arith(A.val[] , B.val[], A.BitCount)
    end
end
function __OR_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    return a_val | b_val
end
function __OR_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == 0x0 || b_val == 0x1
        return UInt8(a_val) | b_val
    end
    return (a_val == 0x1) ? 0x1 : UInt8('x')
end
function __OR_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = a_val
    for i = 1:bitCount
        b = b_val[i]
        if b == 0x0 || b == 0x1
            out_array[i] = UInt8((tmp & 0x1) | b)
        else
            out_array[i] = ((tmp & 0x1) == 0x1) ? 0x1 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __OR_arith(a_val::UInt8, b_val::UInt, bitCount::Int)
    if a_val == 0x0 || a_val == 0x1
        return a_val | UInt8(b_val)
    end
    return (b_val == 0x1) ? 0x1 : UInt8('x')
end
function __OR_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)
    if a_val == 0x1 || b_val == 0x1
        return 0x1
    elseif a_val == 0x0 && b_val == 0x0
        return 0x0
    else
        return UInt8('x')
    end 
end
function __OR_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if     a_val == 0x1 || b_val[] == 0x1
        return 0x1
    elseif a_val == 0x0 && b_val[] == 0x0
        return 0x0
    else
        return UInt8('x')
    end
end
function __OR_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = b_val
    for i = 1:bitCount
        a = a_val[i]
        if a == 0x0 || a == 0x1
            out_array[i] = UInt8((tmp & 0x1) | a)
        else
            out_array[i] = ((tmp & 0x1) == 0x1) ? 0x1 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __OR_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if     a_val[] == 0x1 || b_val == 0x1
        return 0x1
    elseif a_val[] == 0x0 && b_val == 0x0
        return 0x0
    else
        return UInt8('x')
    end
end
function __OR_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:a_bit_c
        if     a_val[i] == 0x1 || b_val[i] == 0x1
            out_array[i] = 0x1
        elseif a_val[i] == 0x0 && b_val[i] == 0x0
            out_array[i] = 0x0
        else
            out_array[i] = 'x'
        end
    end
    return out_array
end

function _NOT_arith(A::Wire)
    return () -> begin
        __NOT_arith(A.val[], A.BitCount)        
    end
end
function __NOT_arith(a_val::UInt, bitCount::Int)
    val = ~a_val
    shift = 63 - bitCount
    return (val << shift) >> shift
end
function __NOT_arith(a_val::UInt8, bitCount::Int)
    if     a_val == 0x1
        return 0x0
    elseif a_val == 0x0
        return 0x1
    else
        return 'x'
    end
end
function __NOT_arith(a_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:bitCount
        bit = a_val[i]
        if     bit == 0x1
            out_array[i] = 0x0
        elseif bit == 0x0
            out_array[i] = 0x1
        else
            out_array[i] = 'x'
        end
    end
    return out_array
end

function _XOR_arith(A::Wire, B::Wire)
    return () -> begin
        __XOR_arith(A.val[], B.val[], A.BitCount)
    end
end
function __XOR_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    return xor(a_val, b_val)
end
function __XOR_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if     b_val == 0x0 || b_val == 0x1
        return xor(UInt8(a_val), b_val)
    else 
        return UInt8('x')
    end
end
function __XOR_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = a_val
    for i = 1:bitCount
        b = b_val[i]
        if b == 0x0 || b == 0x1
            out_array[i] = xor(b, UInt8(tmp & 0x1))
        else
            out_array[i] = UInt8('x')
        end 
        tmp = tmp >> 1
    end
    return out_array
end
function __XOR_arith(a_val::UInt8, b_val::UInt, bitCount::Int)
    if     a_val == 0x0 || a_val == 0x1
        return xor(a_val, UInt8(b_val))
    else 
        return UInt8('x')
    end
end
function __XOR_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)
    if (a_val == 0x0 || a_val == 0x1) && (b_val == 0x0 || b_val == 0x1)
        return xor(a_val, b_val)
    else
        return UInt8('x')
    end
end
function __XOR_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if (a_val == 0x0 || a_val == 0x1) && (b_val[] == 0x0 || b_val[] == 0x1)
        return xor(a_val, b_val[])
    else
        return UInt8('x')
    end    
end
function __XOR_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = b_val
    for i = 1:bitCount
        a = a_val[i]
        if a == 0x0 || a == 0x1
            out_array[i] = xor(a, UInt8(tmp & 0x1))
        else
            out_array[i] = UInt8('x')
        end 
        tmp = tmp >> 1
    end
    return out_array
end
function __XOR_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if (a_val[] == 0x0 || a_val[] == 0x1) && (b_val == 0x0 || b_val == 0x1)
        return xor(a_val[], b_val)
    else
        return UInt8('x')
    end
end
function __XOR_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:bitCount
        a = a_val[i]
        b = b_val[i]
        if (a == 0x0 || a == 0x1) && (b == 0x0 || b == 0x1)
            out_array[i] = xor(a, b)
        else
            out_array[i] = UInt8('x')
        end 
    end
    return out_array
end

function _ADD_arith(A::Wire, B::Wire)
    return () -> begin
       __ADD_arith(A.val[], B.val[], A.BitCount) 
    end
end
function __ADD_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    if bitCount < 64
        return a_val + b_val
    else
        #TODO
    end
end
function __ADD_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == 0x0 || b_val == 0x1
        return a_val + b_val
    else
        if a_val == 0x0
            return [UInt8(0),UInt8('x')]
        else
            return [UInt8('x'), UInt8('x')]
        end
    end
end
function __ADD_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    
end
function __ADD_arith(a_val::UInt8, b_val::UInt, bitCount::Int)

end
function __ADD_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)

end
function __ADD_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)

end
function __ADD_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)

end
function __ADD_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)

end
function __ADD_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)

end

function _MUX_arith(C::Wire, A::Wire, B::Wire)
    return () -> begin
        __MUX_arith(C.val[], A.val[], B.val[], A.BitCount)
    end
end
function __MUX_arith(c_val::UInt, a_val::UInt, b_val::UInt, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt, b_val::UInt8, bitCount::Int)
    return (c_val == 0x1) ? UInt8(a_val) : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    a_array = zeros(UInt8, bitCount)
    Base.digits!(a_val, a_array ,2)
    return (c_val == 0x1) ? a_array : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (c_val == 0x1) ? a_val : Uint8(b_val)
end
function __MUX_arith(c_val::UInt, a_val::UInt8, b_val::UInt8, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val[]
end
function __MUX_arith(c_val::UInt, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    b_array = zeros(UInt8, bitCount)
    Base.digits!(b_val, b_array ,2)
    return (c_val == 0x1) ? a_val : b_array
end
function __MUX_arith(c_val::UInt, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    return (c_val == 0x1) ? a_val[] : b_val
end
function __MUX_arith(c_val::UInt, a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val
end
function __MUX_arith(c_val::UInt8, a_val::UInt, b_val::UInt, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt, b_val::UInt8, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? UInt8(a_val) : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        a_array = zeros(UInt8, bitCount)
        Base.digits!(a_val, a_array ,2)
        return (c_val == 0x1) ? a_array : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt8, b_val::UInt, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : Uint8(b_val)
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val[]
    end
end
function __MUX_arith(c_val::UInt8, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        b_array = zeros(UInt8, bitCount)
        Base.digits!(b_val, b_array ,2)
        return (c_val == 0x1) ? a_val : b_array
    end
end
function __MUX_arith(c_val::UInt8, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val[] : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt, b_val::UInt, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt, b_val::UInt8, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? UInt8(a_val) : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        a_array = zeros(UInt8, bitCount)
        Base.digits!(a_val, a_array ,2)
        return (c_val[] == 0x1) ? a_array : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt8, b_val::UInt, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : Uint8(b_val)
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : b_val[]
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        b_array = zeros(UInt8, bitCount)
        Base.digits!(b_val, b_array ,2)
        return (c_val[] == 0x1) ? a_val : b_array
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val[] : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end

function _LATCH_arith(OUT::Wire, A::Wire, B::Wire)
    return () -> begin
        __LATCH_arith(OUT.val[], A.val[], B.val[], A.BitCount)
    end
end
function __LATCH_arith(out_val::UInt, a_val::UInt, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt8, a_val::UInt, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt8, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt8, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt, a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt8, a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt8, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt8, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end

function REG(Q::Wire, D::Wire, CLK::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _REG_arith(Q, D, CLK)
    reg = Block([D CLK], [Q], f, delays)
    push!(CLK.Dependents, reg)
end
function _REG_arith(Q::Wire, D::Wire, CLK::Wire)
    return () -> begin
        __LATCH_arith(Q.val[], D.val[], CLK.val[], Q.BitCount)
    end
end




function MONITOR(W::Wire)
    f = _MONITOR_arith(W)
    monitor = Block([W], [Wire(64, "Monitor $(W.Name)")], f, Nullable{Array{Float64}}())
    push!(W.Dependents, monitor)
end
function _MONITOR_arith(W::Wire)
    return () -> begin
        global wallclock
        println("$(wallclock)s ... $(W.Name) <- $(W.val[])")
        return W.val[]
    end
end

# TODO write a store function that stores all wire values to a file
=======
# TODO create equivalence, greater, lesser, greterequal, lesserequal
# TODO create add, subtract, mult, divide, rem functions

WireVal = Union{UInt, UInt8, Array{UInt8}}


function CONST(OUT::Wire, val::WireVal, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _CONST_arith(val)
    OUT.val[] = f()
    cnst = Block(Array{Wire}(0), [OUT], f, delays)
end
function EQUALS(OUT::Wire, A::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _EQUALS_arith(A)
    eqls = Block([A], [OUT], f, delays)
    push!(A.Dependent, eqls)
end
function BIT(OUT::Wire, A::Wire, index::Int, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _BIT_arith(A, index)
    bit = Block([A], [OUT], f, delays)
    push!(A.Dependents, bit)
end
function BITS(OUT::Wire, A::Wire, bitEnd::Int, bitStart::Int, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _BITS_arith(A, bitEnd, bitStart)
    bts = Block([A], [OUT], f, delays)
    push!(A.Dependents, bts)
end
function REPEAT(OUT::Wire, A::Wire, repeatCount::Int, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _REPEAT_arith(A, repeatCount)
    rept = Block([A], [OUT], f, delays)
    push!(A.Dependents, rept)
end
function CAT(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _CAT_arith(A, B)
    ct = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, ct)
    push!(B.Dependents, ct) 
end
function AND(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _AND_arith(A, B)
    and = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, and)
    push!(B.Dependents, and)
end
function OR(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _OR_arith(A, B)
    or = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, or)
    push!(B.Dependents, or)
end
function NOT(OUT::Wire, A::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _NOT_arith(A)
    not = Block([A], [OUT], f, delays)
    push!(A.Dependents, not)
end
function XOR(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _XOR_arith(A, B)
    xorr = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, xorr)
    push!(B.Dependents, xorr)
end
function ADD(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _ADD_arith(A, B)
    add = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, add)
    push!(B.Dependents, add)
end
function SUB(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _SUB_arith(A, B)
    subt = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, subt)
    push!(B.Dependents, subt)
end
function MULT(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _MULT_arith(A, B)
    mult = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, mult)
    push!(B.Dependents, mult)
end
function DIV(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _DIV_arith(A, B)
    divd = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, divd)
    push!(B.Dependents, divd)
end
function REM(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _REM_arith(A, B)
    remn = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, remn)
    push!(B.Dependents, remn)
end
function EQUIVALENCE(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _EQUIVALENCE_arith(A, B)
    equ = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, equ)
    push!(B.Dependents, equ)
end
function GREATER(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _GREATER_arith(A, B)
    grt = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, grt)
    push!(B.Dependents, grt)
end
function GREATEREQUAL(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _GREATEREQUAL_arith(A, B)
    ge = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, ge)
    push!(B.Dependents, ge)
end
function LESSER(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _LESSER_arith(A, B)
    lsr = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, lsr)
    push!(B.Dependents, lsr)
end
function LESSEREQUAL(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f == _LESSEREQUAL_arith(A, B)
    le = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, le)
    push!(B.Dependents, le)
end
function MUX(OUT::Wire, C::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _MUX_arith(C, A, B)
    mux = Block([C ; A ; B], [OUT], f, delays)
    push!(C.Dependents, mux)
    push!(A.Dependents, mux)
    push!(B.Dependents, mux)
end
function LATCH(OUT::Wire, A::Wire, B::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _LATCH_arith(OUT, A, B)
    latch = Block([A ; B], [OUT], f, delays)
    push!(A.Dependents, latch)
    push!(B.Dependents, latch)   
end

function _CONST_arith(val::UInt)
    return () -> begin
        val
    end
end
function _CONST_arith(val::UInt8)
    return () -> begin
        val
    end
end
function _CONST_arith(val::Array{UInt8})
    return () -> begin
        val
    end
end

function _EQUALS_arith(A::Wire)
    return () -> begin
        return A.val[]
    end
end

function _BIT_arith(A::Wire, index::Int)
    return () -> begin
        __BIT_arith(A.val[], index)
    end
end
function __BIT_arith(val::Array{UInt8}, index::Int)
    return val[index]
end
function __BIT_arith(val::UInt8, index::Int)
    return val
end
function __BIT_arith(val::UInt, index::Int)
    val = val << (63 - index)
    val >> 63
    return val
end

function _BITS_arith(A::Wire, bitEnd::Int, bitStart::Int)
    return () -> begin
        __BITS_arith(A.val[], bitEnd, bitStart)
    end
end
function __BITS_arith(val::Array{UInt8}, bitEnd::Int, bit_Start::Int)
    return val[(bitStart+1):(bitEnd+1)]
end
function __BITS_arith(val::UInt8, bitEnd::Int, bitStart::Int)
    return val
end
function __BITS_arith(val::UInt, bitEnd::Int, bitStart::Int)
    shift = 63 - bitEnd
    val = val << shift
    val >> (shift + bitStart)
end

function _REPEAT_arith(A::Wire, repeatCount::Int)
    return () -> begin
        __REPEAT_arith(A.val[], UInt(a.BitCount), UInt(repeatCount))
    end
end
function __REPEAT_arith(a_val::UInt, bitCount::UInt, repeatCount::UInt)
    if (bitCount * repeatCount) <= 64
        out = a_val
        for i = 2:repeatCount
            out = (out << bitCount) | a_val
        end
        return out
    else
        a_array = zeros(UInt8, a_bit_c)
        Base.digits!(a_array, a_val, 2) 
        out_array = a_array
        for i = 1:repeatCount
            out_array = [out_array ; a_array]
        end
        return out_array
    end
end
function __REPEAT_arith(a_val::UInt8, bitCount::UInt, repeatCount::UInt)
    out = Array{UInt8}(repeatCount)
    for i = 1:repeatCount
        out[i] = a_val
    end
    return out
end
function __REPEAT_arith(a_val::Array{UInt8}, bitCount::UInt, repeatCount::UInt)
    out = Array{UInt8}(bitCount * repeatCount)
    for i = 1:repeatCount
        out[( ((i-1)*bitCount) + 1):( (i)*bitCount )] = a_val
    end
    return out
end

function _CAT_arith(A::Wire, B::Wire)
    return () -> begin
       __CAT_arith(a.val[], b.val[], a.BitCount, b.BitCount) 
    end
end
function __CAT_arith(a_val::UInt, b_val::UInt, a_bit_c::Int, b_bit_c::Int)
    if (a_bit_c + b_bit_c) <= 64
        return UInt((a_val << b_bit_c) | b_val)
    else
        a_array = zeros(UInt8, a_bit_c)
        b_array = zeros(UInt8, b_bit_c)
        Base.digits!(a_array, a_val, 2) 
        Base.digits!(b_array, b_val, 2)
        return [a_array ; b_array]
    end
end
function __CAT_arith(a_val::UInt, b_val::UInt8, a_bit_c::Int, b_bit_c::Int)
    a_array = zeros(UInt8, a_bit_c)
    Base.digits!(a_array, a_val, 2)    
    return [a_array ; b_val]
end
function __CAT_arith(a_val::UInt, b_val::Array{UInt8}, b_bit_c::Int)
    a_array = zeros(UInt8, a_bit_c)
    Base.digits!(a_array, a_val, 2) 
    return [a_array ; b_val]
end
function __CAT_arith(a_val::UInt, b_val::Array{UInt8}, b_bit_c::Int)
    a_array = zeros(UInt8, a_bit_c)
    Base.digits!(a_array, a_val, 2) 
    return [a_array ; b_val]
end
function __CAT_arith(a_val::UInt8, b_val::UInt, a_bit_c::Int, b_bit_c::Int)
    b_array = zeros(UInt8, b_bit_c)
    Base.digits!(b_array, b_val, 2)
    return [a_val ; b_array]
end
function __CAT_arith(a_val::UInt8, b_val::UInt8, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end
function __CAT_arith(a_val::UInt8, b_val::Array{UInt8}, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end
function __CAT_arith(a_val::Array{UInt8}, b_val::UInt, a_bit_c::Int, b_bit_c::Int)
    b_array = zeros(UInt8, b_bit_c)
    Base.digits!(b_array, b_val, 2)
    return [a_val ; b_array]    
end
function __CAT_arith(a_val::Array{UInt8}, b_val::UInt8, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end
function __CAT_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, a_bit_c::Int, b_bit_c::Int)
    return [a_val ; b_val]
end

function _AND_arith(A::Wire, B::Wire)
    return () -> begin
        __AND_arith(A.val[] , B.val[], A.BitCount)
    end
end
function __AND_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    return a_val & b_val
end
function __AND_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == 0x0 || b_val == 0x1
        return UInt8(a_val) & b_val
    end
    return (a_val == 0x0) ? 0x0 : UInt8('x')    
end
function __AND_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = a_val
    for i = 1:bitCount
        b = b_val[i]
        if b == 0x0 || b == 0x1
            out_array[i] = UInt8(tmp & b)
        else
            out_array[i] = ((tmp & 0x1) == 0x0) ? 0x0 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __AND_arith(a_val::UInt8, b_val::UInt, bitCount::Int)
    if a_val == 0x0 || a_val == 0x1
        return a_val & UInt8(b_val)
    end
    return (b_val == 0x0) ? 0x0 : UInt8('x')
end
function __AND_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)
    if     a_val == 0x0 || b_val == 0x0
        return 0x0
    elseif a_val == 0x1 && b_val == 0x1
        return 0x1
    else
        return UInt8('x')
    end 
end
function __AND_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if     a_val == 0x0 || b_val[] == 0x0
        return 0x0
    elseif a_val == 0x1 && b_val[] == 0x1
        return 0x1
    else
        return UInt8('x')
    end
end
function __AND_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = b_val
    for i = 1:bitCount
        a = a_val[i]
        if a == 0x0 || a == 0x1
            out_array[i] = UInt8(tmp & a)
        else
            out_array[i] = ((tmp & 0x1) == 0x0) ? 0x0 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __AND_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if     a_val[] == 0x0 || b_val == 0x0
        return 0x0
    elseif a_val[] == 0x1 && b_val == 0x1
        return 0x1
    else
        return UInt8('x')
    end
end
function __AND_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:bitCount
        if     a_val[i] == 0x0 || b_val[i] == 0x0
            out_array[i] = UInt8(0)
        elseif a_val[i] == 0x1 && b_val[i] == 0x1
            out_array[i] = UInt8(1)
        else
            out_array[i] = 'x'
        end
    end
    return out_array
end

function _OR_arith(A::Wire, B::Wire)
    return () -> begin
        __OR_arith(A.val[] , B.val[], A.BitCount)
    end
end
function __OR_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    return a_val | b_val
end
function __OR_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == 0x0 || b_val == 0x1
        return UInt8(a_val) | b_val
    end
    return (a_val == 0x1) ? 0x1 : UInt8('x')
end
function __OR_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = a_val
    for i = 1:bitCount
        b = b_val[i]
        if b == 0x0 || b == 0x1
            out_array[i] = UInt8((tmp & 0x1) | b)
        else
            out_array[i] = ((tmp & 0x1) == 0x1) ? 0x1 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __OR_arith(a_val::UInt8, b_val::UInt, bitCount::Int)
    if a_val == 0x0 || a_val == 0x1
        return a_val | UInt8(b_val)
    end
    return (b_val == 0x1) ? 0x1 : UInt8('x')
end
function __OR_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)
    if a_val == 0x1 || b_val == 0x1
        return 0x1
    elseif a_val == 0x0 && b_val == 0x0
        return 0x0
    else
        return UInt8('x')
    end 
end
function __OR_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if     a_val == 0x1 || b_val[] == 0x1
        return 0x1
    elseif a_val == 0x0 && b_val[] == 0x0
        return 0x0
    else
        return UInt8('x')
    end
end
function __OR_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = b_val
    for i = 1:bitCount
        a = a_val[i]
        if a == 0x0 || a == 0x1
            out_array[i] = UInt8((tmp & 0x1) | a)
        else
            out_array[i] = ((tmp & 0x1) == 0x1) ? 0x1 : UInt8('x')
        end
        tmp = tmp >> 1
    end
    return out_array
end
function __OR_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if     a_val[] == 0x1 || b_val == 0x1
        return 0x1
    elseif a_val[] == 0x0 && b_val == 0x0
        return 0x0
    else
        return UInt8('x')
    end
end
function __OR_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:a_bit_c
        if     a_val[i] == 0x1 || b_val[i] == 0x1
            out_array[i] = 0x1
        elseif a_val[i] == 0x0 && b_val[i] == 0x0
            out_array[i] = 0x0
        else
            out_array[i] = 'x'
        end
    end
    return out_array
end

function _NOT_arith(A::Wire)
    return () -> begin
        __NOT_arith(A.val[], A.BitCount)        
    end
end
function __NOT_arith(a_val::UInt, bitCount::Int)
    val = ~a_val
    shift = 63 - bitCount
    return (val << shift) >> shift
end
function __NOT_arith(a_val::UInt8, bitCount::Int)
    if     a_val == 0x1
        return 0x0
    elseif a_val == 0x0
        return 0x1
    else
        return 'x'
    end
end
function __NOT_arith(a_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:bitCount
        bit = a_val[i]
        if     bit == 0x1
            out_array[i] = 0x0
        elseif bit == 0x0
            out_array[i] = 0x1
        else
            out_array[i] = 'x'
        end
    end
    return out_array
end

function _XOR_arith(A::Wire, B::Wire)
    return () -> begin
        __XOR_arith(A.val[], B.val[], A.BitCount)
    end
end
function __XOR_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    return xor(a_val, b_val)
end
function __XOR_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if     b_val == 0x0 || b_val == 0x1
        return xor(UInt8(a_val), b_val)
    else 
        return UInt8('x')
    end
end
function __XOR_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = a_val
    for i = 1:bitCount
        b = b_val[i]
        if b == 0x0 || b == 0x1
            out_array[i] = xor(b, UInt8(tmp & 0x1))
        else
            out_array[i] = UInt8('x')
        end 
        tmp = tmp >> 1
    end
    return out_array
end
function __XOR_arith(a_val::UInt8, b_val::UInt, bitCount::Int)
    if     a_val == 0x0 || a_val == 0x1
        return xor(a_val, UInt8(b_val))
    else 
        return UInt8('x')
    end
end
function __XOR_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)
    if (a_val == 0x0 || a_val == 0x1) && (b_val == 0x0 || b_val == 0x1)
        return xor(a_val, b_val)
    else
        return UInt8('x')
    end
end
function __XOR_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if (a_val == 0x0 || a_val == 0x1) && (b_val[] == 0x0 || b_val[] == 0x1)
        return xor(a_val, b_val[])
    else
        return UInt8('x')
    end    
end
function __XOR_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    tmp = b_val
    for i = 1:bitCount
        a = a_val[i]
        if a == 0x0 || a == 0x1
            out_array[i] = xor(a, UInt8(tmp & 0x1))
        else
            out_array[i] = UInt8('x')
        end 
        tmp = tmp >> 1
    end
    return out_array
end
function __XOR_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if (a_val[] == 0x0 || a_val[] == 0x1) && (b_val == 0x0 || b_val == 0x1)
        return xor(a_val[], b_val)
    else
        return UInt8('x')
    end
end
function __XOR_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    out_array = Array{UInt8}(bitCount)
    for i = 1:bitCount
        a = a_val[i]
        b = b_val[i]
        if (a == 0x0 || a == 0x1) && (b == 0x0 || b == 0x1)
            out_array[i] = xor(a, b)
        else
            out_array[i] = UInt8('x')
        end 
    end
    return out_array
end

function _ADD_arith(A::Wire, B::Wire)
    return () -> begin
       __ADD_arith(A.val[], B.val[], A.BitCount) 
    end
end
function __ADD_arith(a_val::UInt, b_val::UInt, bitCount::Int)
    if bitCount < 64
        return a_val + b_val
    else
        #TODO
    end
end
function __ADD_arith(a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == 0x0 || b_val == 0x1
        return a_val + b_val
    else
        if a_val == 0x0
            return [UInt8(0),UInt8('x')]
        else
            return [UInt8('x'), UInt8('x')]
        end
    end
end
function __ADD_arith(a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    
end
function __ADD_arith(a_val::UInt8, b_val::UInt, bitCount::Int)

end
function __ADD_arith(a_val::UInt8, b_val::UInt8, bitCount::Int)

end
function __ADD_arith(a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)

end
function __ADD_arith(a_val::Array{UInt8}, b_val::UInt, bitCount::Int)

end
function __ADD_arith(a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)

end
function __ADD_arith(a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)

end

function _MUX_arith(C::Wire, A::Wire, B::Wire)
    return () -> begin
        __MUX_arith(C.val[], A.val[], B.val[], A.BitCount)
    end
end
function __MUX_arith(c_val::UInt, a_val::UInt, b_val::UInt, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt, b_val::UInt8, bitCount::Int)
    return (c_val == 0x1) ? UInt8(a_val) : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    a_array = zeros(UInt8, bitCount)
    Base.digits!(a_val, a_array ,2)
    return (c_val == 0x1) ? a_array : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (c_val == 0x1) ? a_val : Uint8(b_val)
end
function __MUX_arith(c_val::UInt, a_val::UInt8, b_val::UInt8, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val
end
function __MUX_arith(c_val::UInt, a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val[]
end
function __MUX_arith(c_val::UInt, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    b_array = zeros(UInt8, bitCount)
    Base.digits!(b_val, b_array ,2)
    return (c_val == 0x1) ? a_val : b_array
end
function __MUX_arith(c_val::UInt, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    return (c_val == 0x1) ? a_val[] : b_val
end
function __MUX_arith(c_val::UInt, a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    return (c_val == 0x1) ? a_val : b_val
end
function __MUX_arith(c_val::UInt8, a_val::UInt, b_val::UInt, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt, b_val::UInt8, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? UInt8(a_val) : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        a_array = zeros(UInt8, bitCount)
        Base.digits!(a_val, a_array ,2)
        return (c_val == 0x1) ? a_array : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt8, b_val::UInt, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : Uint8(b_val)
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val[]
    end
end
function __MUX_arith(c_val::UInt8, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        b_array = zeros(UInt8, bitCount)
        Base.digits!(b_val, b_array ,2)
        return (c_val == 0x1) ? a_val : b_array
    end
end
function __MUX_arith(c_val::UInt8, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val[] : b_val
    end
end
function __MUX_arith(c_val::UInt8, a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    if c_val == UInt8('x') || c_val == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt, b_val::UInt, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt, b_val::UInt8, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? UInt8(a_val) : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt, b_val::Array{UInt8}, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        a_array = zeros(UInt8, bitCount)
        Base.digits!(a_val, a_array ,2)
        return (c_val[] == 0x1) ? a_array : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt8, b_val::UInt, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : Uint8(b_val)
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::UInt8, b_val::Array{UInt8}, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val : b_val[]
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        b_array = zeros(UInt8, bitCount)
        Base.digits!(b_val, b_array ,2)
        return (c_val[] == 0x1) ? a_val : b_array
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val[] == 0x1) ? a_val[] : b_val
    end
end
function __MUX_arith(c_val::Array{UInt8}, a_val::Array{UInt8}, b_val::Array{UInt8}, bitCount::Int)
    if c_val[] == UInt8('x') || c_val[] == UInt8('z')
        return fill(UInt8('x'), bitCount)
    else
        return (c_val == 0x1) ? a_val : b_val
    end
end

function _LATCH_arith(OUT::Wire, A::Wire, B::Wire)
    return () -> begin
        __LATCH_arith(OUT.val[], A.val[], B.val[], A.BitCount)
    end
end
function __LATCH_arith(out_val::UInt, a_val::UInt, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt8, a_val::UInt, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt8, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt8, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt8, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt, bitCount::Int)
    return (b_val == 1) ? a_val : out_val
end
function __LATCH_arith(out_val::UInt, a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt8, a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt8, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::UInt8, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::UInt8, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end
function __LATCH_arith(out_val::Array{UInt8}, a_val::Array{UInt8}, b_val::UInt8, bitCount::Int)
    if b_val == UInt8('x') || b_val == UInt8('x')
        return fill(UInt8('x'), bitCount)
    else
        return (b_val == 1) ? a_val : out_val
    end
end

function REG(Q::Wire, D::Wire, CLK::Wire, delays::Nullable{Array{Float64}} = Nullable{Array{Float64}}())
    f = _REG_arith(Q, D, CLK)
    reg = Block([D CLK], [Q], f, delays)
    push!(CLK.Dependents, reg)
end
function _REG_arith(Q::Wire, D::Wire, CLK::Wire)
    return () -> begin
        __LATCH_arith(Q.val[], D.val[], CLK.val[], Q.BitCount)
    end
end




function MONITOR(W::Wire)
    f = _MONITOR_arith(W)
    monitor = Block([W], [Wire(64, "Monitor $(W.Name)")], f, Nullable{Array{Float64}}())
    push!(W.Dependents, monitor)
end
function _MONITOR_arith(W::Wire)
    return () -> begin
        global wallclock
        println("$(wallclock)s ... $(W.Name) <- $(W.val[])")
        return W.val[]
    end
end

# TODO write a store function that stores all wire values to a file
# TODO write a truncate file which says whenever a BITS operation loses data