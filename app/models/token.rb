# == Schema Information
#
# Table name: tokens
#
#  id              :integer         not null, primary key
#  hashed_access_token    :string(255)     not null
#  hashed_refresh_token   :string(255)     not null
#  expires_on      :date            not null
#  refresh_by      :date            not null
#  user_id         :integer         not null

class Token < ActiveRecord::Base
  attr_accessible :hashed_refresh_token, :hashed_access_token, :expires_on, :user_id, :refresh_by
  attr_accessor :refresh_token, :access_token
  belongs_to :user

  def Token.generate(user)
    t = Token.new
    t.user = user
    t.access_token = SecureRandom.hex
    t.refresh_token = SecureRandom.hex
    t.hashed_access_token = Digest::SHA2.hexdigest(t.access_token)
    t.hashed_refresh_token = Digest::SHA2.hexdigest(t.refresh_token)
    t.expires_on = Time.zone.now + 7.days
    t.refresh_by = Time.zone.now + 30.days
    t.save!
    t
  end

  def Token.refresh(refresh_token)

    hashed_refresh_token = Digest::SHA2.hexdigest(refresh_token)
    token = Token.find_by_hashed_refresh_token(hashed_refresh_token)
    if token and token.refresh_by > Time.zone.now

      #TODO for social tokens we need to call the specific provider to refresh the token
      user = token.user
      token.delete
      token = Token.generate(user)
      token
    else
      nil
    end
  end

  def Token.user_for_token(access_token)
    hashed_access_token = Digest::SHA2.hexdigest(access_token)
    token = Token.find_by_hashed_access_token(hashed_access_token)
    if token and token.refresh_by > Time.zone.now
      token.user
    else
      nil
    end
  end

end

