require 'csv'

class Comparer
  def initialize(args)
    path1 = args.first or raise ArgumentError #"can't find #{path1}"
    path2 = args.last or raise ArgumentError #"can't find #{path2}"
    
    @csv1 = CSV.read(path1, headers: true)
    @csv2 = CSV.read(path2, headers: true) 
  end
  
  def run
    puts "In first, but not in second:"
    puts a_not_b.sort
    puts
    puts "In second, not in first:"
    puts b_not_a.sort
    exit 0
  end

  private

  def a_not_b
  	holdings_a - holdings_b
  end

  def b_not_a
  	holdings_b - holdings_a
  end

  def intersect_count
  	holdings_a & holdings_b
  end

  def holdings_a
	@holdings_a ||= @csv1['Holding name']
  end

  def holdings_b
	@holdings_b ||= @csv2['Holding name']
  end
end

exit Comparer.new(ARGV).run if $0 == __FILE__
