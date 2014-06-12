# _*_ coding:utf-8 _*_
require 'calculate.rb' # 計算のためのプログラム

# 与えられたハッシュ{key:単語,value:出現回数}から、各単語のtf値を求める関数
# r_hash(空のハッシュ)に{key:単語,value:tf値}を格納する
def tf(hash,num,r_hash)# numは,hashに現れる語の種類の数
	hash.each_pair{|k,v|
		tf = v / num.to_f
		r_hash.store(k,tf)
	}
	return r_hash
end

def idf(file_num,word_num)
	n = file_num.to_f / word_num
	return 1.0 + log_n(n,2)
end
