module TweetHelper 
  def body(tweet)
    if tweet.media?
      text = tweet.attrs[:full_text].sub(/ https:\/\/t\.co\/[0-9a-zA-Z]{10}$/, '')
    else
      text = tweet.attrs[:full_text]
    end

    tweet.attrs[:entities][:urls].each do |urls|
      text.sub!(urls[:url], urls[:expanded_url])
    end

    # リプライの場合、もしくは(@)ユーザー名がツイート内にある場合
    if tweet.attrs[:entities][:user_mentions]
      # @〜をリンクにする
    end

    # ハッシュタグがある場合
    # リンクにする

    #引用ツイートがある場合
    #引用したツイートを小さく表示する

    simple_format(text_url_to_link(h(text)))
  end

  def media(tweet)
    if tweet.media.first.class == Twitter::Media::Photo
      # 画像表示
      # TODO: width100%ではなく、heightを基準に表示する
      # TODO: 複数画像を添付してる場合にも対応する
      image_tag('https://pbs.twimg.com' + tweet.media.first.media_url.path, class: 'media')
    elsif tweet.media.first.class == Twitter::Media::Video
      # 動画表示
      display_video(tweet)
    end
  end

  def display_video(tweet)
    if tweet.media.first.video_info.variants.first[:content_type] == "application/x-mpegURL"
    
    else
      video_tag('https://video.twimg.com' + tweet.media.first.video_info.variants.first.url.path, muted: true, controls: true, class: 'media')
    end
  end

  def youtube_thumbnail(tweet)
    tweet_text = tweet.attrs[:full_text]
    youtube_text = ['https://youtu.be', 'https://www.youtube.com/watch?v=']
    return unless youtube_text.any? { |t| tweet_text.include?(t) }
    
    mark =
      if tweet_text.include?('youtube.com/watch?v=')
        /\?v=/.match(tweet_text)
      else
        %r{youtu.be/}.match(tweet_text)
      end
    

    content_tag 'iframe', nil, src: ('https://www.youtube.com/embed/' + mark.post_match.split.first), \
      frameborder: 0, gesture: 'media', allow: 'encrypted-media', allowfullscreen: true, class: 'embed_youtube'

    # https://youtu.be/N-fu7VqT3qk
    # https://www.youtube.com/watch?v=N-fu7VqT3qk
    # image_tag('https://img.youtube.com/vi/' +  + '/hqdefault.jpg')
  end

  def text_url_to_link text 
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
   
      text.gsub!(url, sub_text)
    end
   
    return text
  end
end