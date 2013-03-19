module Octonaut

  command :foo do |c|
    c.action do |global,options,args|
      puts "bar"
    end
  end

end
