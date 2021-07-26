class CoursesController < ApplicationController
  include Rails::Pagination

  def index
    paginate json: Course.includes(:tutors).as_json(include: :tutors), links: {}
  end

  def create
    @course  = Course.new(course_params)
    if @course.save!
  	  render json: {id: @course.id}, status: :created
    else
  	  reder json: @course.errors.as_json, status: :unprocessable_entity
    end
  end

  private
  def course_params
    params.require(:course).permit(:title, tutors_attributes: [:name])
  end

end
