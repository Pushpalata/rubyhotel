class TokensController < ApplicationController

  respond_to :json
  
  def create
    email = params[:email]
    password = params[:password]
    if request.format != :json
      render :status=>406, :json=>{:message=>"The request must be json"}
      return
    end
    
    if email.nil? or password.nil?
       render :status=>400,
              :json=>{:message=>"The request must contain the user email and password."}
       return
    end
 
    @user=User.find_by_email(email.downcase)
    if @user.nil?
      render :status=>401, :json=>{:message=>"Invalid email or passoword."}
      return
    end
 
    if not @user.valid_password?(password)
      logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:message=>"Invalid email or password."}
    else
      render :status=>200, :json=>{:token=>@user.access_token}
    end    
  end
 
  def reset_token
    # reset the token for security
    @user=User.find_by_access_token(params[:auth_token])
    if @user.nil?
      render :status=>404, :json=>{:message=>"Invalid token."}
    else
      @user.reset_access_token!
      render :status=>200, :json=>{:token=>params[:auth_token]}
    end
  end
 
end