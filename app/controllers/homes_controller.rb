class HomesController < ApplicationController
  def top
    @materials = Material.approved.order(created_at: :desc).limit(3)
  end
end
