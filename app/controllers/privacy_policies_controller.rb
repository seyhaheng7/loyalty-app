class PrivacyPoliciesController < ApplicationController
  before_action :set_privacy_policy, only: [:update]

  def index
    authorize :privacy_policy
    @privacy_policy = PrivacyPolicy.first_or_create
  end

  def update
    authorize @privacy_policy
    if @privacy_policy.update(privacy_policy_params)
      redirect_to privacy_policies_path, notice: 'Privacy policy was successfully updated.'
    else
      render :index
    end
  end

  private
    def set_privacy_policy
      @privacy_policy = PrivacyPolicy.find(params[:id])
    end

    def privacy_policy_params
      params.require(:privacy_policy).permit(:body)
    end
end
