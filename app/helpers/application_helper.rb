module ApplicationHelper
  def site_title 
    'UNEP-WCMC Annual Review'
  end

  def site_description
    'UNEP-WCMC Annual Review'
  end

  def page_title
    content_for?(:title) ? content_for(:title) : site_title
  end

  def url_encode text
    ERB::Util.url_encode(text)
  end

  def encoded_home_url
    url_encode(request.base_url)
  end

  def social_image
    # image_url('social.jpg')
  end

  def social_image_alt
    ''
  end

  def create_sharing_facebook_link
    title = url_encode('Share ' + page_title + ' on Facebook')
    url = encoded_home_url
    href = 'https://facebook.com/sharer/sharer.php?u=' + url

    link_to '', href, title: title, class: 'social__icon social__icon--facebook', target: '_blank'
  end

  def create_sharing_twitter_link
    title = url_encode('Share ' + page_title + ' on Twitter')
    text = url_encode('UNEP-WCMC Annual Review')
    url = encoded_home_url
    href = 'https://twitter.com/intent/tweet/?text=' + text + '&url=' + url
    
    link_to '', href, title: title, class: 'social__icon social__icon--twitter', target: '_blank'
  end

  def create_sharing_email_link
    title = url_encode('Share ' + page_title + ' via Email')
    url = encoded_home_url
    subject = url_encode(site_title)
    body = site_description + url_encode("\n\n") + url
    href = 'mailto:?subject=' + subject + '&body=' + body

    link_to '', href, title: title, class: 'social__icon social__icon--email', target: '_self'
  end
end
