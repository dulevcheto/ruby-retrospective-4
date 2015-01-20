module RBFS
  class File
    attr_accessor :data
    def initialize(some_data = nil)
      @data = some_data
    end

    def data_type
      return :nil     if(@data.is_a? NilClass)
      return :string  if(@data.is_a? String)
      return :symbol  if(@data.is_a? Symbol)
      return :number  if(@data.is_a? Bignum or @data.is_a? Float or @data.is_a? Integer)
      return :boolean if(@data.is_a? TrueClass or @data.is_a? FalseClass)
    end

  def serialize
  "#{self.data_type}:#{self.data}"
  end

  def self.parse(string_data)
    File.new(string_data.split(':').pop)
  end
  end

  class Directory
    attr_accessor :files, :directories
    def initialize
      @files = {}
      @directories = {}
    end

    def add_file(name, file)
      @files[name] = file
    end

  def add_directory(name, directory=Directory.new)
      @directories[name] = directory
    end

  def [](name)
    return  @directories[name] if(@directories.include? name)
    @files[name]
    end

  def serialize
    result = ''
    result += "#{@files.length}:"
    @files.each_pair do |key,value|
    result += "#{key}:#{value.serialize.length}:#{value.serialize}"
    end
    result += "#{@directories.length}:"
    @directories.each_pair do|key, value|
    result+="#{key}:#{value.serialize.length}:#{value.serialize}"
    end
    result
  end
  end
end