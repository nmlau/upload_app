class UploadsController < ApplicationController

def index
  @user = current_user
  @uploads = Upload.where("user_id = ?", @user.id)
end

def new
  @upload = current_user.uploads.build if signed_in?
end

def create
  @upload = current_user.uploads.build(upload_params)
  if @upload.save
    flash[:success] = "Upload created!"
    redirect_to uploads_path
  else
    render root_path
  end
end

def edit
  @upload = Upload.find(params[:id])
end

def update
  @upload = Upload.find(params[:id])
  if @upload.update_attributes(upload_params)
    flash[:success] = "Upload updated"
    redirect_to uploads_path
  else
    render uploads_path
  end
end

def destroy
  @upload.destroy
  redirect_to root_url
end

private
  def upload_params
    params.require(:upload).permit(:link, :sepia, :watermark, :vertflip)
  end
end