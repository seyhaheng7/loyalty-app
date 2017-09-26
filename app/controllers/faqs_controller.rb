class FaqsController < ApplicationController
  
  before_action :set_faq, only: [:show, :edit, :update, :destroy]

  # GET /faqs
  def index
    @grid = FaqsGrid.new(params[:faqs_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /faqs/1
  def show
    authorize @faq
  end

  # GET /faqs/new
  def new
    @faq = Faq.new
    authorize @faq
  end

  # GET /faqs/1/edit
  def edit
    authorize @faq
  end

  # POST /faqs
  def create
    @faq = Faq.new(faq_params)
    authorize @faq
    if @faq.save
      redirect_to @faq, notice: 'Faq was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /faqs/1
  def update
    authorize @faq
    if @faq.update(faq_params)
      redirect_to @faq, notice: 'Faq was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /faqs/1
  def destroy
    authorize @faq
    @faq.destroy
    redirect_to faqs_url, notice: 'Faq was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq
      @faq = Faq.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def faq_params
      params.require(:faq).permit(:title, :content)
    end
end
