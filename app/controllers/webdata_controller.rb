include SendGrid

class WebdataController < ApplicationController
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
    # 取得に使ったjsは不要
    remove_pattern = /http:\/\/localhost:3000\/js\/core\.js/;
    p remove_pattern
    webdatum_formatted = params[:webdatum].gsub(remove_pattern, "")

    webdatum = Webdatum.new({url: params[:url], title:params[:title], webdata:webdatum_formatted})
    p webdatum
    webdatum.save
    send_mail

    redirect_to(params[:url])
  end

  #TODO 外部から色々指定する
  # メール送信
  def send_mail
    from = Email.new(email: ENV['MY_MAIL_FROM'])
    subject = 'test mail!'
    to = Email.new(email: ENV['MY_MAIL_TO'])
#    content = Content.new(type: 'text/plain', value: 'Hello, Email!')
#    content = Content.new(type: 'text/html', value: '<html><head></head><body>Hello, <br><b>Email!</b></body></html>')
    content = Content.new(type: 'text/html', value: 'Hello, <br><b>Email!</b>')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
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

end
