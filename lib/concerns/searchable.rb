module Searchable
  def search_by_first_char(char)
    @array = all.select {|obj| obj.name[0] == char.upcase || obj.name[0] == char.downcase }
  end

  def search_by_string(string)
    @array = all.select {|obj| !obj.name.downcase.match(string.downcase).nil? }
  end
end