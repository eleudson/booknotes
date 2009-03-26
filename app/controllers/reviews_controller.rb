class ReviewsController < ApplicationController
  before_filter :login_required, :load_publication, :except => :index

  # GET /reviews
  # GET /reviews.xml
  def index
    @reviews = Review.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    #@review = Review.find(params[:id])
    @review = @publication.review
    debugger
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    #@review = Review.find(params[:id])
    @review = @publication.review
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    #@review = Review.find(params[:review])
    @review = @publication.build_review(params[:review])

    respond_to do |format|
      if @review.save
        flash[:notice] = 'Review was successfully created.'
        format.html { redirect_to publication_review_path(@publication) }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    #@review = Review.find(params[:id])
    @review = @publication.review

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to publication_review_path(@publication) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    #@review = Review.find(params[:id])
    @publication.review.destroy

    respond_to do |format|
      format.html { redirect_to publication_path(@publication) }
      format.xml  { head :ok }
    end
  end

  private

  def load_publication
    @publication = Publication.find(params[:publication_id])
  end
end
