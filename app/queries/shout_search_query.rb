class ShoutSearchQuery
  def initialize(term: )
    @term = term
  end

  def to_relation
    Shout.search { fulltext term }.results
  end

  private

  attr_reader :term
end