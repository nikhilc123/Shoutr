class SessionsController < Clearance::SessionsController

  private

  #override clearance sessions method
  # do not care what parameters is being passed ie. (_)
  def authenticate(_)
    super(session_params)
  end

  def session_params
    { session: session_params_with_email }
  end

  def session_params_with_email
    #check _form.html
    # user method returns a record - get email (method under Guest) from that
    params.
        require(:session).
        permit(:password).
        merge(email: user.email)
  end

  def user
    #returns relation so use .first record
    #Error scenario: if returns nil, use guest object
    User.where(email: email_or_username).or(User.where(username: email_or_username)).first || Guest.new
  end

  def email_or_username
    #check form.label attribute
    params[:session][:email_or_username]
  end
end