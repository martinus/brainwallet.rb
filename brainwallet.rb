#!/usr/bin/env ruby
require 'digest/sha2'

def base16_to_base58(addr)
    letters = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".unpack("C*") 
    s = ""
    num = addr.to_i(16)
    begin    
        s += letters[num % 58].chr
        num /= 58
    end while num != 0
    s.reverse
end

def pwd_to_privatekey(pwd)
    h = "\x80" + Digest::SHA256.digest(pwd)
    h += Digest::SHA256.digest(Digest::SHA256.digest(h))[0...4]
    base16 = h.unpack('H*')[0]
    base16_to_base58(base16)
end

print "Enter password: "
pwd = gets[0...-1]
puts
puts "password:    [#{pwd}]"
puts "private key: [#{pwd_to_privatekey(pwd)}]"
