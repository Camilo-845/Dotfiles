function _herdr_ratio --description 'Emitir una proporción como float' --argument-names numerator denominator
    awk -v a=$numerator -v b=$denominator 'BEGIN { printf "%.4f", a / b }'
end
