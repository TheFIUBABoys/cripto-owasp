class SqlInjectionObjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
  end

  def create
    @sql_object = SqlInjectionObject.new(sql_injection_objects_params)

    @sql_object.save
    redirect_to @sql_object
  end

  def show
    @sql_object = SqlInjectionObject.find(params[:id])
  end

  def destroy
    #Sample id injection, move this to request when everything works
    params[:id] = "1) OR 1=1--"
    print("id = #{params[:id]}\n")
    #Now ALL records will be deleted due to injection
    SqlInjectionObject.delete_all("id = #{params[:id]}")
    redirect_to action: 'index'
  end

  def index
      @sql_objects = SqlInjectionObject.all
  end

  private
  def sql_injection_objects_params
    params.require(:sql_injection_object).permit(:title, :text)
  end
end