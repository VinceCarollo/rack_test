require 'rack'

class PersonalSite
  def self.call(env)
    case env["PATH_INFO"]
    when '/'
      index
    when '/about'
      about
    when '/myblog'
      blog
    when '/main.css'
      css
    when '/vince.jpg'
      self_pic
    when /blog\/*/
      single_blog(env["PATH_INFO"])
    else
      error
    end
  end

  def self.self_pic
    render_pic('vince.jpg')
  end

  def self.css
    render_static('main.css')
  end

  def self.index
    render_view('index.html')
  end

  def self.single_blog(path)
    render_view(path + ".html")
  end

  def self.blog
    render_view('blog.html')
  end

  def self.about
    render_view('about.html')
  end

  def self.error
    render_view('error.html', '404')
  end

  def self.render_view(page, code = '200')
    [code, {'Content-Type' => 'text/html'}, [File.read("./app/views/#{page}")]]
  end

  def self.render_static(asset)
    [200, {'Content-Type' => 'text/html'}, [File.read("./public/#{asset}")]]
  end

  def self.render_pic(asset)
    [200, {'Content-Type' => 'image/jpeg'}, [File.read("./public/images/#{asset}")]]
  end
end
