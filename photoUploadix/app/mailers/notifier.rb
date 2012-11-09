class Notifier < ActionMailer::Base
  def send_registration_confirmation(user)
      @user = user
      mail(:to => user.email,
        :subject => "Confirm your registration on photoUploadix",
        :from => "registration@photouploadix.com.au"
    )

    end
end