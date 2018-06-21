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

      params[:formations].each do |formation|
        formation = Formation.create( formation_params(formation) )
      end

      params[:professional_experiences].each do |experience|
        formation = ProfessionalExperience.create( experience_params(experience) )
      end

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

    def formation_params(formation)
      form_params = formation.permit(
        :institution,
        :course,
        :concluded,
        :start_date,
        :end_date
      )
      form_params[:curriculum_id] = @curriculum.id
      return form_params
    end

    def experience_params(experience)
      exp_params = experience.permit(
        :company_name,
        :role,
        :start_date,
        :end_date
      )
      exp_params[:curriculum_id] = @curriculum.id
      return exp_params
    end
end
