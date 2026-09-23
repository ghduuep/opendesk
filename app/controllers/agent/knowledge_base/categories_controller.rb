class Agent::KnowledgeBase::CategoriesController < Agent::BaseController
  before_action :set_category, only: %i[show destroy]
  def index
    @categories = Current.account.knowledge_base_categories.order(:position, :name)
  end

  def show
    @articles = @category.articles.order(created_at: :desc)
  end

  def new
    @category = Current.account.knowledge_base_categories.new
  end

  def create
    @category = Current.account.knowledge_base_categories.new(category_params)

    if @category.save
      redirect_to agent_knowledge_base_root_path, notice: "Category created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!

    redirect_to agent_knowledge_base_root_path, notice: "Category deleted successfully"
  end

  private

  def set_category
    @category = Current.account.knowledge_base_categories.find(params[:id])
  end

  def category_params
    params.require(:knowledge_base_category).permit(
      :name,
      :description
    )
  end
end
