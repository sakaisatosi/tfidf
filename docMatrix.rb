# -*- coding: utf-8 -*-
### 使用する際に気をつけること
# 1. 読み込むDIRECTORY名を任意に変更する(18行目)
# 2. 結果出力ファイルも任意に変更する(14行目)
# 3. 結果をExcelで読み込みたいときは、$ nkf -s --overwrite 結果ファイル名
#    (文字コードをutf-8からShift-jisに変更)

### 別ファイルをインクルード ### 
require 'jlma.rb' # 形態素解析をするためのプログラム
require 'tf_idf.rb' # ti,idf,tf-idfの値を計算するプログラム
require 'calculate.rb' # 計算のためのプログラム

# 結果を出力するファイル
w_file = open("result.txt","w")

# ディレクトリ内のすべてのファイル名を読み込む
@filename = Array.new # ファイル名を格納するArray
DIRECTORY = "file"
Dir::foreach(DIRECTORY) {|f|
  if ((f != "." ) && (f != "..")) then
    @filename.push([DIRECTORY+f,f])
  end
}
@f_num = @filename.length

#### プログラム本体 ####
# 以下のようにマークしておく
# tf計算のために使用 → #tf
# idf計算のために使用 → #idf

@tf = Hash.new #tf

@idf = Hash.new #idf
@idf.default = 0.0 #idf
@word_number = Hash.new #idf{key:ファイル名, value：単語の種類数}
@word_number.default = 0.0

@tfidf = Hash.new

@filename.each{|tempfile|
  openfile = tempfile[0] # パスも含めてすべて表示
  fname = tempfile[1] # ファイル名のみ
  puts fname + "：tf_value"+"..."
  # 現在のファイルで使用するHashの定義
  h = Hash.new #tf
  h.default = 0.0
  # 現在のファイルで現れる単語の総数
  temp_num = 0.0
  # ファイル読み込み
  file = open(okashira.rb)
  text = file.read
  # 形態素解析の結果を得る
  jlma = jlma(text)
  # 現在のファイルに出現した語の頻度を格納する #tf
  # 全ファイルの出現した語の頻度を格納する #idf
  jlma.each{|aj|
    word = aj[0]
    # 出現したら、回数を１増やす (出現回数上書きのため)
    case h[word]  
    when 0.0
      # tf計算のため
      temp_num += 1.0
      time_temp = 1.0
      # idf計算のため
      time_idf = @word_number[word] + 1.0
      @word_number.store(word,time_idf)
    else
      # tf計算のため
      temp_num += 1.0
      time_temp = h[word] + 1.0
    end
 
    # key:語が格納された配列、value:出現回数
    h.store(word,time_temp) #tf
  }
  file.close
  
  # tf-value を求める
  h_r = Hash.new
  # 現在のファイルでの単語の出現回数の結果から、tfを計算し、結果をh_rに入れる
  temp = tf(h,temp_num,h_r)
  # ファイル名、そのファイルの各単語のtf値のハッシュを格納
  @tf.store(fname,temp)
}

puts "idf_value ..."
@word_number.each{|w,v|
  @idf.store(w,idf(@f_num,v))
}

puts "tf-idf_value ..."

=begin
# 結果をこの先の計算でも使う場合
@tf.each{|file,h|
  tfidf_h = Hash.new
  @idf.each{|word,idf|
    if (h[word] != nil) then
      tfidf = h[word]*idf
    else
      tfidf = 0.0
    end
    tfidf_h.store(word,tfidf)
  }
  @tfidf.store(file,tfidf_h)
}
=end

# ファイルに書き出す

### 行列を転置した状態で出力
# １行目
w_file.print("\t")
n = 1
idfsize = @idf.size
@idf.each_key{|word|
  w_file.print(word)
  if n != idfsize then w_file.print("\t") end
  n += 1
}
w_file.print("\n")
# ２行目以降
@tf.each{|file,h|
  w_file.print(file+"\t")
  counter = 0
  @idf.each{|word,idf|
    counter += 1
    if (h[word] != nil) then
      tfidf = h[word]*idf
    else
      tfidf = 0.0
    end
    w_file.print(tfidf)
    if counter!=idfsize then w_file.print("\t") end
  }
  w_file.print("\n")
}

w_file.close



=begin
@tfidf.each{|f,v|
  puts "*ファイル名:" + f
  v.each{|w,vv|
    puts w + "：" + vv.to_s
  } 
}
=end

=begin
@idf.each{|w,v|
  puts w + "：" + v.to_s
}
=end
