class Admin::DashboardController < Admin::BaseController
  def show
    if params[:tutorial] == 'create'
      tutorial = Tutorial.last
      link = "<a href=/tutorials/#{tutorial.id}>View it here</a>"
      flash[:success] = "Successfully created tutorial. #{link}.".html_safe
    end
    @facade = AdminDashboardFacade.new
  end
end
