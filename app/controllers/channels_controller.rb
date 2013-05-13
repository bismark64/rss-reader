class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  # GET /channels
  # GET /channels.json
  def index
    @user = current_user

    if params[:search].present?
      @search = @user.channels.solr_search do
        fulltext params[:search]
      end
      @channels = @search.results
    else
      @channels = @user.channels
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @channels }
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    @user = current_user
    @channel = @user.channels.find(params[:id])

    if params[:search].present?
      @search = @channel.articles.solr_search do
        fulltext params[:search]
        with(:channel_id, params[:id])
      end
      @articles = @search.results
    else
      @articles = @channel.articles.order('"pubDate" DESC')
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @channel }
    end
  end

  # GET /channels/new
  # GET /channels/new.json
  def new
    @user = current_user
    @channel = @user.channels.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @channel }
    end
  end

  # GET /channels/1/edit
  def edit
    @user = current_user
    @channel = @user.channels.find(params[:id])
  end

  # POST /channels
  # POST /channels.json
  def create
    @user = current_user
    @channel = Channel.fetch_from_url(params[:channel][:url], current_user.id) unless params[:channel][:url].blank?
      
    respond_to do |format|
      if @channel
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render json: @channel, status: :created, location: @channel }
      else
        format.html { 
          flash[:alert] = 'The provided url is not a RSS/Atom valid source.'
          flash.keep
          redirect_to action: "new"
        }
      end
    end
  end

  # PUT /channels/1
  # PUT /channels/1.json
  def update
    @user = current_user
    @channel = @user.channels.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @user = current_user
    @channel = @user.channels.find(params[:id])
    @channel.destroy

    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end
end
