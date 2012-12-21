command :me do |c|
  c.action do |global,options,args|
    data = Octokit.user('pengwynn')

    # data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
  end
end
