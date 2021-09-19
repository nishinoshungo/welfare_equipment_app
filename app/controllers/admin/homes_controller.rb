class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, only: [:menu]

  def top
  end

  def menu
  end
end
