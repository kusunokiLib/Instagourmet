class HomeController < ApplicationController
  def index
    render 'vue', layout: false
  end
end
