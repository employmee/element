class SubjectsController < ApplicationController
  def index
    @subjects = current_user.subjects
  end
end
