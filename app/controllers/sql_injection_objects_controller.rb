class SqlInjectionObjectsController < ApplicationController
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

  def index
    @sql_objects = SqlInjectionObject.all
  end

  private
  def sql_injection_objects_params
    params.require(:sql_injection_object).permit(:title, :text)
  end
end