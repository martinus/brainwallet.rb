#!/usr/bin/env ruby
require 'digest/sha2'

def base16_to_base58(addr)
    s = ""
    num = addr.to_i(16)
    while num != 0 do
        s += "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"[num % 58]
        num /= 58
    end
    s.reverse
end

def pwd_to_privatekey(pwd)
    a = "\x80" + Digest::SHA256.digest(pwd)
    b = Digest::SHA256.digest(a)
    b = Digest::SHA256.digest(b)
    b = b[0...4]
    b = a + b
    base16 = b.unpack('H*')[0]
    base16_to_base58(base16)
end

# this script just imports everything. A separate script periodically sweeps everything.
pwd = ARGV[0]
puts "password:    [#{pwd}]"
puts "private key: [#{pwd_to_privatekey(pwd)}]"