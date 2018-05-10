class Wordfreq
  attr_accessor :filename
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @filename = filename
  end

  def frequency(word)
    file = File.read @filename
    new_array = file.downcase.gsub(/[^a-z\s]/, " ").split(' ')
    filtered = new_array.delete_if { |a| STOP_WORDS.include?(a)}
    filtered.count(word)
  end

  def frequencies
    file = File.read @filename
    new_array = file.downcase.gsub(/[^a-z\s]/, " ").split(' ')
    filtered = new_array.delete_if { |a| STOP_WORDS.include?(a)}
    results_array = filtered.map do |x|
        wordcount = frequency(x)
        [x, wordcount]
      end
      results_array.to_h
  end

  def top_words(number)
    freq_array = frequencies.to_a
    sorted = freq_array.sort_by { |k, v| [-v, k] }
    (0..(number - 1)).map { |x| sorted[x] }
  end


  def print_report
    report = top_words()
  end
end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
