# 受け取った文字列を形態素解析して、結果を配列に入れて返す関数
def jlma_ch(ch) # Japanese language morphological analysis
  mecab = MeCab::Tagger.new()
  node = mecab.parseToNode(ch)
  ary = Array.new
  while node do
    ary.push("#{node.feature}".split(","))
    # ary.push( "#{node.surface}\t#{node.feature}")
    node = node.next
  end
  arysize = ary.size
  return ary.slice(1..(arysize-2))
end

# 受け取った形態素解析の結果のうち、必要な情報だけを保存しておく関数
def jlma601(ary)
  ra = Array.new
  ary.each{|a|
    a1 = a[1]
     if ((a[0] == "名詞")|(a[0] == "形容詞")) then
       if((a1 != "非自立")&&
          (a1 != "接尾")&&
          (a1 != "数")#&&
          #(a1 != "")#&& # 必要があれば条件追加 
          #(a1 != "")#&&
          #(a1 != "")#&&
          #(a1 != "")#&&
) then
       ra.push([a[6],a[0],a[1]]) # [形態素原形, 品詞, さらに細かい分類]
       end
     end
  }
  return ra
end

# jlma_ch → jilma601 の順に適用させる関数
def jlma(ch)
  return jlma601(jlma_ch(ch))
end