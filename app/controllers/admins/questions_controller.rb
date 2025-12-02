class Admins::QuestionsController < Admins::BaseController
	before_action :set_question, except: [:index, :new, :create]

  def index
		if params[:search].blank?
			criteria = Question.all
		else
			criteria = Question.where("question ILIKE ?", "%#{params[:search]}%")
		end

    @questions = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
      format.js
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question)
    if @question.save
			redirect_to admins_question_path(@question.id), :notice => "Successfully created question."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(params_question)
			redirect_to admins_question_path(@question.id), :notice  => "Successfully updated question."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to admins_questions_url, :notice => "Successfully destroyed question."
  end

  private

  def params_question
    params.require(:question).permit(:question, :answer, :category_name)
  end

  def set_question
		@question = Question.find(params[:id])
  end
end
