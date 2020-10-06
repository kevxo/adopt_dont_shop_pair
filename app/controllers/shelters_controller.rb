class SheltersController < ApplicationController
  def index
    @shelters = ['Shelter 1', 'Shelter 2', 'Shelter 3']
  end
end