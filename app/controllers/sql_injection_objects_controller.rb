class SqlInjectionObjectsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :html, :js

  def index
    @sql_objects = SqlInjectionObject.all
  end

  def new
  end

  def show
    @sql_object = SqlInjectionObject.find params[:id]
  end

  def create
    sql_object = SqlInjectionObject.new sql_injection_objects_params

    sql_object.save
    redirect_to sql_object
  end

  def destroy
    # Sample id injection: "1) OR 1=1--" => Deletes ALL records

    # Sample request for postman:
    # http://localhost:3000/sql_injection_objects/1) OR 1=1--
    deleted = SqlInjectionObject.delete_all "id = #{params[:id]}"

    render json: deleted
  end

  def destroy_protected
    # Sample id injection: "1) OR 1=1--" => Deletes ALL records

    # Sample request for postman:
    # http://localhost:3000/sql_injection_objects/1) OR 1=1--/destroy_protected
    deleted = SqlInjectionObject.find_by(id: params[:id])
    deleted.destroy if deleted.present?

    render json: deleted
  end

  private

  def sql_injection_objects_params
    params.require(:sql_injection_object).permit(:title, :text)
  end

end
