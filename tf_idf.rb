# _*_ coding:utf-8 _*_
require 'calculate.rb' # �׻��Τ���Υץ����

# Ϳ����줿�ϥå���{key:ñ��,value:�и����}���顢��ñ���tf�ͤ����ؿ�
# r_hash(���Υϥå���)��{key:ñ��,value:tf��}���Ǽ����
def tf(hash,num,r_hash)# num��,hash�˸�����μ���ο�
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
