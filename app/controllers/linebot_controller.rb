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
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          # LINEから送られてきたメッセージが「アンケート」と一致するかチェック
          if event.message['text'].eql?('アンケート')
            # コメントにしたコード
            # private内のtemplateメソッドを呼び出します。
            # client.reply_message(event['replyToken'], template)
            
            # 試しに追加したコード
            userid = event['source']['userId']  #userId取得
            message = { type: 'text', text: 'プッシュ送信のテスト成功しました' }
            client.push_message(userid, message) #push送信
          end
        end
      end
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

