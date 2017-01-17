class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index

    @results = Product.all
    @results = @results.where("name = ?", params[:search]) unless params[:search].nil? || params[:search].empty?
    @results = @results.where(:featured => true) if params[:featured] == "on"
    @results = @results.where("price >= #{params[:minPrice].to_d}")    unless params[:minPrice].nil? || params[:minPrice].empty?
    @results = @results.where("price <= #{params[:maxPrice].to_d}")    unless params[:maxPrice].nil? || params[:maxPrice].empty?
    @results = @results.where("quantity >= #{params[:minStock].to_i}") unless params[:minStock].nil? || params[:minStock].empty?
    @results = @results.where("quantity <= #{params[:maxStock].to_i}") unless params[:maxStock].nil? || params[:maxStock].empty?
    @results = @results.where("rating >= #{params[:ratings].to_d}")    unless params[:ratings].nil?

    @pages = (@results.count / 10.to_f).ceil
    @page = (params[:page].nil? || !params[:page].to_i) ? 1 : params[:page].to_i
    @products = Product.get_results(@results).offset((@page - 1) * 10).limit(10)

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :quantity, :manufacturer)
    end
end
