class Admin::TutorialsClassroomController < Admin::BaseController
  def update
    tutorial = Tutorial.find(params[:id])
    tutorial.toggle_classroom if params[:classroom]
    tutorial.save
    redirect_to admin_dashboard_path
  end
end
