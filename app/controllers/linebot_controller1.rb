class LinebotController < ApplicationController
  require 'line/bot'
  # そのメソッドだけCSRF対策を無効にしたいというときはexceptで指定する
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    # jsonを読み込む
    body = request.body.read
    
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event

    # ここから　カテキョボットがフォローされた場合、Useの中にuid_lineがあるか調べ、なかったら新規登録する機能
      # （ちょっと強引。後でメールアドレスの取得し、チェックする機能をつける）
      # もしくはフォローのイベントで新規作成するこの機能を削除する
      when Line::Bot::Event::Follow #フォローイベント
      user_id = event['source']['userId']  #LINEのuserId取得
      user = User.find_by(uid: user_id)
      # userがnilならアプリに登録していないとし、新規作成する
      # if user == nil
      #   user = User.new
      #   user.uid = user_id
      #   user.save
      #   message = { type: 'text', text: 'カテキョに登録しました' }
      # else
      #   message = { type: 'text', text: '登録しました' }
      # end
      message = { type: 'text', text: 'フォローありがとうございます' }
      client.push_message(user.uid, message) #push送信
    # ここまでカテキョボットがフォローされた場合、Useの中にuid_lineがあるか調べ、なかったら新規登録する機能

      when Line::Bot::Event::Message # メッセージイベント。ユーザーがカテキョアプリにメッセージを送った場合
        case event.type
        when Line::Bot::Event::MessageType::Text
          # LINEから送られてきたメッセージが「アンケート」と一致するかチェック
          if event.message['text'].eql?('予約')
          # ここからコメントにしたコード 以下2行
            # private内のtemplateメソッドを呼び出します。
            # client.reply_message(event['replyToken'], template)
          # ここまでコメントにしたコード

            # ここから試しに追加したコード
            userid = event['source']['userId']  #userId取��
            message = { type: 'text', text: '予約状況はxxxです。' }
            client.push_message(userid, message) #push送信
            # ここまで試しに追加したコード
          elsif event.message['text'].eql?('明日空いてる')
            # userid = event['source']['userId']  #userId取得
            # message = { type: 'text', text: 'おはよう' }
            # client.push_message(userid, message) #push送信
            #
            @lessons = Lesson.where(lesson_date: Date.current)
            
            if @lessons.empty?
              message = { type: 'text', text: '明日予約できる家庭教師はいません。' }
              message
            else
              available_tutors = []
              @lessons.each do|lesson|
              
              available_tutors.push(lesson.user_id)
              available_tutors
            end
        
            message = { type: 'text', text: "明日予約できる家庭教師は・・・#{available_tutors[0]}さんです。" }
            message
            end
            client.reply_message(event['replyToken'], message)
          end  # if event.message['text'].eql?('予約')に対するend
        end # case event.typeに対応するend
        
      end # case event (25行目)に対応するend
    }

    head :ok
  end
  
  # 自作関数　ユーザーにメッセージを送る機能
  # def send_message
  #   message={
  #   type: 'text',
  #   text: '(送信したいメッセージ)'
  #   }
    
    # user_id = uから始まるLINEの送信先識別子
    # response = client.push_message(user_id, mesage)
  # end
  
  private

  def template
    {
      "type": "template",
      "altText": "this is a confirm template",
      "template": {
          "type": "confirm",
          "text": "今日のもくもく会は楽しいですか？",
          "actions": [
              {
                "type": "message",
                # Botから送られてきたメッセージに表示される文字列です。
                "label": "楽しい",
                # ボタンを押した時にBotに送られる文字列です。
                "text": "楽しい"
              },
              {
                "type": "message",
                "label": "楽しくない",
                "text": "楽しくない"
              }
          ]
      }
    }
  end
end

