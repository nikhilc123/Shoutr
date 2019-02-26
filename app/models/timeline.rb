#dont inherit Application Record since it is not a Relationship
# line - l: small

# #Timeline is not an ActiveModel-compatible path. It must go to partial path:
# two solutions: def to_partial_path or include ActiveModel::Conversion

class Timeline
  #scope = Scope
  # dependency injection, we can extract some details, search for something within that
  def initialize(users, scope = Shout)
    @users = users
    @scope = scope
    #after this it automatically goes to_partial_path
  end

  def shouts
    scope.
        where(user_id: users).
        order(created_at: :desc)
  end

  def to_partial_path
    "timelines/timeline"
  end

  private

  attr_reader :users, :scope

end