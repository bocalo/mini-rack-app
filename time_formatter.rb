class TimeFormatter
  FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H', 'minute' => '%M', 'second' => '%S' }

  attr_reader :invalid_string

  def initialize(params)
    @params = params['format'].split(',')
  end

  def check_format
     @valid_string, @invalid_string = @params.partition { |format| FORMATS[format] }
    # @formats = @valid_string.map { |format| FORMATS[format] }
    @params.each do |param|
      if FORMATS[param]
        @valid_string << FORMATS[param]
      else
        @invalid_string << param
      end
    end
    Time.now.strftime(@valid_string.join('-'))
  end

  def success?
    @invalid_string.empty?
  end

  def error
    "Unknown time format #{@invalid_string}"
  end

  # def time
  #   #Time.now.strftime(@formats.join('-'))
  #   Time.now.strftime(@valid_string.join('-'))
  # end
end

