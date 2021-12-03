def caesarCipher(s, k)
    # Write your code here
    ascii = s.chars.map { |c| c.ord }
    k = k % 26
    shifted = ascii.map do |c|
        if c <= 90 && c >= 65
            (c + k) > 90 ? c = 65 + (c + k - 91) : c = c + k
        elsif c <= 122 && c >= 97
            (c + k) > 122 ? c = 97 + (c + k - 123) : c = c + k
        else
            c
        end
    end
    shifted.map { |c| c.chr }.join
end
