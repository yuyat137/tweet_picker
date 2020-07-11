module TweetHelper
  def body(tweet)
    text = if tweet.media?
             tweet.attrs[:full_text].sub(%r{https://t\.co/[0-9a-zA-Z]{10}\Z}, '')
           else
             tweet.attrs[:full_text]
           end

    # t.co URLを通常のURLに戻す
    tweet.attrs[:entities][:urls].each do |urls|
      text.sub!(urls[:url], urls[:expanded_url])
    end
    # URLをリンクに変換する
    url_texts = ['http://', 'https://']
    url_texts.each do |url_text|
      mark = text.match(url_text)
      next unless mark

      url = url_text + mark.post_match.split.first
      link = "<a href='" + url + "'>" + url + '</a>'
      text.gsub!(url, link)
    end

    # リプライの場合、もしくは(@)ユーザー名がツイート内にある場合
    mentions_info = tweet.attrs[:entities][:user_mentions].first
    unless mentions_info.blank?
      mention_text = '@' + mentions_info[:screen_name]
      link = "<a href='https://twitter.com/" + mentions_info[:screen_name] + '/status/' + tweet.id.to_s + "' target=\"_blank\" rel=\"noopener\">" + mention_text + '</a>'
      text.gsub!(mention_text, link)
    end
    # TODO: ここ、何故か別タグにならない問題が

    # ハッシュタグがある場合
    # TODO: 現状バグ有り。例：#ガルパと#ガルパ超電磁砲Tコラボ開催中がハッシュタグの場合
    tweet.attrs[:entities][:hashtags]&.each do |hashtag|
      link = "<a href='https://twitter.com/hashtag/" + hashtag[:text] + "?src=hashtag_click'>#" + hashtag[:text] + '</a>'
      text.gsub!('#' + hashtag[:text], link)
    end
    # 引用ツイートがある場合
    # 引用したツイートを小さく表示する
    # simple_format(text_url_to_link(h(text)))

    text
  end

  def media(tweet)
    if tweet.media.first.class == Twitter::Media::Photo
      # 画像表示
      # TODO: 複数画像を添付してる場合にも対応する
      image_tag('https://pbs.twimg.com' + tweet.media.first.media_url.path, class: 'media')
    elsif tweet.media.first.class == Twitter::Media::Video
      # 動画表示
      display_video(tweet)
    end
  end

  def display_video(tweet)
    if tweet.media.first.video_info.variants.first[:content_type] == 'application/x-mpegURL'

    else
      video_tag('https://video.twimg.com' + tweet.media.first.video_info.variants.first.url.path, muted: true, controls: true, class: 'media')
    end
  end

  def youtube_thumbnail(tweet)
    tweet_text = tweet.attrs[:full_text]
    youtube_text = ['youtu.be', 'youtube.com/watch?v=']
    return unless youtube_text.any? { |t| tweet_text.include?(t) }

    mark =
      if tweet_text.include?('youtube.com/watch?v=')
        /\?v=/.match(tweet_text)
      else
        %r{youtu.be/}.match(tweet_text)
      end

    return unless mark

    content_tag 'iframe', nil, src: ('https://www.youtube.com/embed/' + mark.post_match.split.first), \
                               frameborder: 0, gesture: 'media', allow: 'encrypted-media', allowfullscreen: true, class: 'embed_youtube'
  end

  def text_url_to_link(text)
    URI.extract(text, %w[http https]).uniq.each do |url|
      sub_text = ''
      sub_text << '<a href=' << url << ' target="_blank">' << url << '</a>'

      text.gsub!(url, sub_text)
    end

    text
  end

  def reply_url(tweet)
    'https://twitter.com/intent/tweet?in_reply_to=' + tweet.id.to_s
  end

  def favorite_url(tweet)
    'https://twitter.com/intent/like?tweet_id=' + tweet.id.to_s
  end

  def retweet_url(tweet)
    'https://twitter.com/intent/retweet?tweet_id=' + tweet.id.to_s
  end

  def tweet_url(tweet)
    'https://twitter.com/' + tweet.user.screen_name + '/status/' + tweet.id.to_s
  end
end
