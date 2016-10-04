include SendGrid
include Common

class WebdataController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_webdatum, only: [:show, :edit, :update, :destroy]


  # GET /webdata
  # GET /webdata.json
  def index
    @webdata = Webdatum.all
  end

  # GET /webdata/1
  # GET /webdata/1.json
  def show
  end

  # GET /webdata/new
  def new
    @webdatum = Webdatum.new
  end

  # GET /webdata/1/edit
  def edit
  end

  # POST /webdata
  # POST /webdata.json
  def create
    @webdatum = Webdatum.new(webdatum_params)

    respond_to do |format|
      if @webdatum.save
        format.html { redirect_to @webdatum, notice: 'Webdatum was successfully created.' }
        format.json { render :show, status: :created, location: @webdatum }
      else
        format.html { render :new }
        format.json { render json: @webdatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /webdata/1
  # PATCH/PUT /webdata/1.json
  def update
    respond_to do |format|
      if @webdatum.update(webdatum_params)
        format.html { redirect_to @webdatum, notice: 'Webdatum was successfully updated.' }
        format.json { render :show, status: :ok, location: @webdatum }
      else
        format.html { render :edit }
        format.json { render json: @webdatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webdata/1
  # DELETE /webdata/1.json
  def destroy
    @webdatum.destroy
    respond_to do |format|
      format.html { redirect_to webdata_url, notice: 'Webdatum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def api_create
    # 簡単な認証
    if (ENV['PASSWORD'] != Digest::SHA256.hexdigest(params[:pw]))
      p "password miss"
      redirect_to(params[:url])
      return
    end

    # 取得に使ったjsは不要
    url_pattern = Regexp.escape(getUrl + "\/core.js?")
    remove_pattern = /#{url_pattern}[0-9a-zA-Z=]*/;
    p remove_pattern
    webdatum_formatted = params[:webdatum].gsub(remove_pattern, "")

    webdatum = Webdatum.new({url: params[:url], title:params[:title], webdata:webdatum_formatted})
    p webdatum
    webdatum.save

    send_mail(
      ENV['MY_MAIL_FROM'],
      ENV['MY_MAIL_TO'],
      mail_title(params[:title]),
      mail_body(params[:url], params[:title], webdatum_formatted)
    )

    redirect_to(params[:url])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webdatum
      @webdatum = Webdatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def webdatum_params
      params.require(:webdatum).permit(:url, :title, :webdata)
    end

    def mail_title(title)
      "[atode]" + title
    end

    def mail_body(url, title, webdata)
      #ヘッダは不要？
      remove_pattern = /<head>(.*)<\/head>/m;
      webdatum_formatted = webdata.gsub(remove_pattern, "")

      ENV['TZ'] = 'Asia/Tokyo'
      t = Time.now
      time_str = t.strftime("%Y年%m月%d日 %H:%M:%S")
      info_html = "<div style='border:#000 solid 1px; padding:10px;'>このページは#{time_str}に「#{title}」( #{url} )から取得しました。</div>"
      mail_body = info_html + webdatum_formatted
      mail_body
    end
end
