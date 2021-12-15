module ApplicationHelper
  def sign_in_or_out
    if signed_in?
      button_to "Sair", session_destroy_path, class: 'me-2'
    else
      button_to "Sign in with Twitch", '/auth/twitch', class: 'me-2'
    end
  end
end
