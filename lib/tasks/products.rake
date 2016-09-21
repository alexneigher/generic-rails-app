def choose(file)
File.foreach("lib/dictionaries/#{file}.txt").each_with_index.reduce(nil) { |q,r|
  rand < 1.0/(1+r[1]) ? r[0] : q }
end
