(1..100).each do |n|
  if n.%(3).zero?
    print "Fizz"
    if n.%(5).zero? 
      print "Buzz"
    end
  elsif n.%(5).zero?
    print "Buzz"
  else
    print n
  end
  print "\n"
end