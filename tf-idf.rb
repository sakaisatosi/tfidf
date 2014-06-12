# encoding: utf-8
require 'rubygems'
require 'tf_idf'


#data = [%w{a a a a a a a a b b ああ あああ ああ ああ}, %w{a a}]
data = ["a a a a a a a a b b ああ あああ ああ ああ".encode("utf-8"), "a a"]

a = TfIdf.new(data)

# To find the term frequencies
a.tf
  #=> [{'b' => 0.2, 'a' => etc...}, {'a' => 1}]

# To find the inverse document frequency
a.idf
  #=> {'b' => 0.301... etc...}

# And to find the tf-idf
a.tf_idf.each do |obj|
  obj.each do |k, v|
     p "#{k} => #{v}"
  end
end
#p a.tf_idf.force_encoding("utf-8")
  #=> [{'b' => 0.0602, 'a' => etc...}, {etc...}]
