class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    begin
      tutorial = Tutorial.new(title: params[:tutorial][:title],
                              description: params[:tutorial][:description],
                              thumbnail: params[:tutorial][:thumbnail])

      tutorial.save
      flash[:success] = "Successfully created a tutorial!"
      redirect_to "/tutorials/#{tutorial.id}"
    rescue StandardError
      flash[:error] = 'Unable to create tutorial.'
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
