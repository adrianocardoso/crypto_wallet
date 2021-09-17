class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Adriano Cardoso [COOKIES]"
    session[:curso] = "Curso de Ruby on Rails - Adriano Cardoso [SESSION]"
    @meu_nome = params[:nome]
  end
end
