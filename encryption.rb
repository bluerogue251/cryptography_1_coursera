def xor_bin_strings(string_1, string_2)
  arr_1 = string_to_int_array(string_1)
  arr_2 = string_to_int_array(string_2)

  raise 'Different lengths' unless arr_1.length == arr_2.length

  arr_1.map.with_index { |el_1, i| xor_ints(el_1, arr_2[i]) }.join('')
end

def string_to_int_array(s)
  s.split('').map { |s| Integer(s) }
end

def xor_ints(int_1, int_2)
  (int_1 + int_2) % 2
end

def hex_str_to_bin_str(hex_string)
  hex_string.to_i(16).to_s(2).rjust(hex_string.length*4, '0')
end

def bin_str_to_hex_str(bin_string)
  bin_string.to_i(2).to_s(16).rjust(bin_string.length/4, '0')
end

def asc_str_to_bin_str(asc_str)
  asc_str.unpack('b*').first
end

def bin_str_to_asc_str(bin_str)
  [bin_str].pack('b*')
end

ct_in_hex = '09e1c5f70a65ac519458e7e53f36'
puts "ct_in_hex (length #{ct_in_hex.length}) is #{ct_in_hex}"
ct_in_bin = hex_str_to_bin_str(ct_in_hex)
puts "ct_in_bin (length #{ct_in_bin.length}) is #{ct_in_bin}"

pt_in_asc = 'attack at dawn'
pt_in_bin = asc_str_to_bin_str(pt_in_asc)
puts "pt_in_bin (length #{pt_in_bin.length}) is #{pt_in_bin}"

otp_e_key = xor_bin_strings(ct_in_bin,  pt_in_bin)
puts "otp_e_key (length #{otp_e_key.length}) is #{otp_e_key}"

mt_in_asc = 'attack at dusk'
mt_in_bin = asc_str_to_bin_str(mt_in_asc)
otp_m_enc_in_bin = xor_bin_strings(otp_e_key, mt_in_bin)
otp_m_enc_in_hex = bin_str_to_hex_str(otp_m_enc_in_bin)

puts "otp_m_enc_in_hex (length #{otp_m_enc_in_hex.length}) is #{otp_m_enc_in_hex}"
