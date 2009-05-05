class NotesController < ApplicationController
  before_filter :login_required, :load_publication

  # GET /notes
  # GET /notes.xml
  def index
    #@notes = @publication.notes.find(:all)
    @notes = @publication.note.paginate :page => params[:page], :per_page => 15

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = @publication.notes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = @publication.notes.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = @publication.notes.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = @publication.notes.build(params[:note])

    respond_to do |format|
      if @note.save
        flash[:notice] = 'Note was successfully created.'
        format.html { redirect_to([@publication, @note]) }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = @publication.notes.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        flash[:notice] = 'Note was successfully updated.'
        format.html { redirect_to([@publication, @note]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = @publication.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(publication_notes_url(@publication)) }
      format.xml  { head :ok }
    end
  end
  
  private

  def load_publication
    @publication = Publication.find(params[:publication_id])
  end
end
