class HomesController < ApplicationController
  def top
    @materials = Material.all.order(created_at: :desc).limit(4)
  end
end
