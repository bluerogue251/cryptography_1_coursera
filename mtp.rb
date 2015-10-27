require './crypto_utils'

def u
  CryptoUtils
end

def source_ciphertexts
  File.readlines('mtp_ciphertexts.txt').map { |ct| u.htb(ct.strip) }
end

def target_ciphertext
  u.htb(File.read('target_ciphertext.txt').strip)
end

def xm(targ)
  source_ciphertexts.map { |source| u.xor_ss(source, targ) }
end

def find_spaces_in(source)
  s = 0
  e = 7
  starting_thingys = []
  (source.length / 8).times do |time|
    result_array = xm(source).map { |str| u.bta(str[s..e]).to_s }
    show = result_array.keep_if { |l| ('A'..'Z').include?(l) }.length > 5
    if show
      starting_thingys << s
      puts "S: #{s.to_s.rjust(4, ' ')} E: #{e.to_s.rjust(4, ' ')} #{result_array}"
    end
    s += 8
    e += 8
  end

  puts starting_thingys.inspect
end

# puts find_spaces_in(source_ciphertexts[9])

# def p
#   s = 0
#   e = 7
#   (target_ciphertext.length / 8).times do |time|
#     puts "S: #{s.to_s.rjust(4, ' ')} E: #{e.to_s.rjust(4, ' ')}"
#     s += 8
#     e += 8
#   end
# end

def space
  u.atb(' ')
end

# spaces_in_ct_0 = [16, 48, 104, 136, 192, 200, 216, 256, 280, 320, 400, 408, 432, 464, 504, 560, 592, 648, 672, 712, 728, 848]
# spaces_in_ct_1 = [40, 88, 160, 208, 248, 312, 376, 440, 456, 512, 560, 584, 640, 656, 744, 832]
# spaces_in_ct_2 = [24, 64, 160, 224, 248, 304, 424, 456, 504, 520, 552, 576, 624, 664, 672, 680, 712]
# spaces_in_ct_3 = [24, 184, 208, 224, 264, 280, 352, 432, 480, 504, 544, 568, 656, 728, 752]
# spaces_in_ct_4 = [24, 56, 72, 136, 168, 184, 216, 240, 272, 280, 312, 352, 368, 400, 432, 528, 552, 624, 664, 672, 680, 720, 800]
# spaces_in_ct_5 = [40, 72, 104, 152, 176, 288, 296, 336, 384, 424, 464, 528, 568, 608, 648, 704, 800, 840]
# spaces_in_ct_6 = [40, 72, 104, 152, 176, 312, 352, 408, 440, 528, 552, 584, 632, 680, 704, 752, 784, 832, 864, 896]
# spaces_in_ct_7 = [16, 48, 80, 160, 208, 240, 304, 368, 392, 408, 456, 488, 512, 552, 584, 656, 696, 744, 784, 816, 960]
# spaces_in_ct_8 = [8, 80, 120, 128, 216, 272, 280, 328, 344, 440, 496, 512, 592, 624, 712, 776, 856]
# spaces_in_ct_9 = [32, 96, 232, 248, 264, 272, 288, 360, 416, 440, 472, 504, 528, 536, 600, 616, 632, 696, 744, 752]

# spaces_in_ct_9.each do |s|
#   e = s + 7
#   puts "#{s}: #{u.bta(u.xor(target_ciphertext[s..e], source_ciphertexts[9][s..e]))}"
# end

def target_plaintext
  'The secret message is: When using a stream cipher, never use the key more than once.'
end

def key
  u.xor_ss(target_ciphertext, u.atb(target_plaintext))
end

puts u.bta(u.xor_ss(key, source_ciphertexts[4]))
