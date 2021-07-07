include ActionView::Helpers::UrlHelper

module ApplicationHelper
  def site_title
    'UNEP-WCMC Annual Review'
  end

  def site_description
    'Putting nature at the heart of decision-making'
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
    image_url('riverside-house.jpg')
  end

  def social_image_alt
    'A house by the side of a river'
  end

  def create_sharing_facebook_link
    title = url_encode('Share ' + page_title + ' on Facebook')
    url = encoded_home_url
    href = 'https://facebook.com/sharer/sharer.php?href=' + url

    link_to '', href, title: title, class: 'social__icon social__icon--facebook', target: '_blank'
  end

  def create_sharing_twitter_link
    title = url_encode('Share ' + page_title + ' on Twitter')
    text = url_encode('In 2020, we put nature at the heart of decision-making, while also working from home. Read @unepwcmc’s 2020 Annual Review: https://annualreview.unep-wcmc.org/')
    url = encoded_home_url
    href = 'https://twitter.com/intent/tweet/?text=' + text + '&url=' + url

    link_to '', href, title: title, class: 'social__icon social__icon--twitter', target: '_blank'
  end

  def create_sharing_linkedin_link
    title = url_encode('Share ' + page_title + ' on LinkedIn')
    url = encoded_home_url
    href = 'https://www.linkedin.com/sharing/share-offsite/?url=' + url

    link_to '', href, title: title, class: 'social__icon social__icon--linkedin', target: '_blank'
  end

  def create_sharing_email_link
    title = url_encode('Share ' + page_title + ' via Email')
    url = encoded_home_url
    subject = url_encode("UNEP-WCMC's Annual Review 2020")
    body = url_encode("In 2020, we put nature at the heart of decision-making, while also working from home.\n\n Read @unepwcmc’s 2020 Annual Review: ") + url
    href = 'mailto:?subject=' + subject + '&body=' + body

    link_to '', href, title: title, class: 'social__icon social__icon--email', target: '_self'
  end
end
