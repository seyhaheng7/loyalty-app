class SettingsController < ApplicationController
  before_action :set_setting, only: [:edit, :update]

  def index
    @settings = Setting.get_all
  end

  def edit
    authorize @setting
  end

  def update
    authorize @setting
    if @setting.update(setting_params)
      redirect_to settings_path, notice: 'Setting was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def setting_params
      params.require(:setting).permit(:value)
    end
end
