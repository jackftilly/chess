class InvalidMove < StandardError
  def initialize
    @msg = "This is an invalid move!"
    super
  end

end
