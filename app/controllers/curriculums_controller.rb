class CurriculumsController < ApplicationController

  # GET /curriculums
  def index
    page = params[:page] ? params[:page] : 1
    per_page = params[:per_page] ? params[:per_page] : 10

    curriculums = Curriculum.where("active = ?", true)
                             .order(score: :desc)
                             .page(page).per(per_page)
    count = Curriculum.where("active = ?", true).count

    render json: {
      data: curriculums,
      count: count,
      page: page.to_i,
      per_page: per_page.to_i
    }, include: ["formations", "professional_experiences"]
  end

  # POST /curriculums
  def create
    @curriculum = Curriculum.new(curriculum_params)
    @curriculum.score = 1 + (rand * 9)

    if @curriculum.save
      render json: @curriculum, status: :created, location: @curriculum
    else
      render json: @curriculum.errors, status: :unprocessable_entity
    end
  end

  private
    def curriculum_params
      curr_params = params.permit(
        :active, :picture,
        :birthdate, :name,
        :gender, :email,
        :phone, :address,
        :latitude, :longitude,
        :tags
      )
      curr_params[:active] = true
      return curr_params
    end
end
