module CryptoUtils
  def self.xor_ss(s1, s2)
    low_length = [s1.length, s2.length].min - 1
    xor(s1[0..low_length], s2[0..low_length])
  end

  def self.xor(string_1, string_2)
    arr_1 = string_1.chars.to_a
    arr_2 = string_2.chars.to_a

    raise 'Different lengths' unless arr_1.length == arr_2.length

    arr_1.map.with_index { |arr_1_el, i| xor_ints(arr_1_el, arr_2[i]) }.join('')
  end

  def self.xor_ints(i1, i2)
    (Integer(i1) + Integer(i2)) % 2
  end

  def self.htb(hex_string)
    hex_string.to_i(16).to_s(2).rjust(hex_string.length*4, '0')
  end

  def self.bth(bin_string)
    bin_string.to_i(2).to_s(16).rjust(bin_string.length/4, '0')
  end

  def self.atb(asc_str)
    asc_str.unpack('B*').first
  end

  def self.bta(bin_str)
    [bin_str].pack('B*')
  end

  def self.hta(hex_str)
    [hex_str].pack('H*')
  end

  def self.ath(asc_str)
    asc_str.unpack('H*')
  end
end

# Tests for hex-bin string encoding
# puts bin_str_to_hex_str(hex_str_to_bin_str('09e1c5f70'))

# Tests for asc-bin string encoding
# puts bin_str_to_asc_str(asc_str_to_bin_str('I am a cookie monster'))

# Tests for xor-ing strings
# puts xor_bin_strings('0000', '0000'), '0000'
# puts xor_bin_strings('1111', '0000'), '1111'
# puts xor_bin_strings('1010', '0000'), '1010'
# puts xor_bin_strings('1010', '1010'), '0000'
# puts xor_bin_strings('1111', '1111'), '0000'
# puts xor_bin_strings('1010', '0101'), '1111'

