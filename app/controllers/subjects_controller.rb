class SubjectsController < ApplicationController
  def index
    @listed_subjects = current_user.subjects.where(listed: true)
    @unlisted_subjects = current_user.subjects.where(listed: false)

  end

  def update
    params.permit(:id)
    params.permit(:listed)
    # params.require(:subject).permit(:listed)
    # params.require(:subject).permit(:id)
    subject = Subject.find(params['id'])
    subject.update(listed: params['listed'])
    subject.save!

  end

  def bulk
    subject_name = params["subject"]
    if subject_name.nil? || subject_name == "Select subject"
      flash[:error] = "You did not select a subject"
      redirect_to subjects_path
    end
    new_subject = Subject.new(name: subject_name, user: current_user)

    if Grade::GRADES.any? { |grade| params[grade] == "on" }
      new_subject.save!
    else
      flash[:error] = "You did not select any grades"
      redirect_to subjects_path
    end

    Grade::GRADES.each { |grade| create_grades(grade, new_subject) }
    # List the subject created
    new_subject.list!
    new_subject.save
    redirect_to subjects_path
  end

  private

  def subjects_params
    params.require(:subject).permit(:name, :listed)
  end

  def create_grades(grade, subject)
    if params[grade] == "on"
      rate = params["#{grade} Rate"]
      if rate.nil?
        flash[:error] = "You did not enter an hourly rate for #{grade}"
        redirect_to subjects_path
      end
      grade = Grade.new(name: grade, hourly_rate: rate.to_f, subject: subject)
      grade.save
    end
  end
end
