---
layout: post
title: How to use AMP Image Tags to Display Images in Jekyll
description: You will learn how to build a custom plugin to generate amp-img tag instead of img tag in Jekyll.
image: /assets/2019-12-25-how-to-use-amp-image-tags-to-display-images-in-jekyll/banner.jpg
date: 2019-12-25 00:00:00 +08:00:00
categories:
    - code
tags:
    - jekyll
---

## Introduction

AMP image tags (`amp-img`) are a better alternative to native HTML image tags (`img`) in AMP pages. AMP image tags [lazy-load images](https://web.dev/offscreen-images/?utm_source=lighthouse&utm_medium=unknown) outside the first viewport automatically. More details about AMP image tags from [AMP official website](https://amp.dev/documentation/guides-and-tutorials/develop/media_iframes_3p/?format=websites#images).

Jekyll uses native HTML image tags to display images by default. We need to custom the default markdown parser to generate AMP image tags instead of native HTML image tags. Fortunately, we don’t have to develop a markdown parser from zero. What we have to do is only inherit the default markdown parser and override the particular method, which parses the markdown image expression to the native HTML image tags.

*If you are new to Jekyll, you can read my **[Jekyll beginner's guide in 5 minutes](/jekyll-beginner-guide.html)** to learn basics or access [Jekyll's official website](https://jekyllrb.com/) to systematic learn it.*

## 1. Create a Jekyll website project

Run command `jekyll new demo-website` in your prompt.

## 2. Create *_plugins* folder in the root directory of your website

Enter the root directory of your website you just created by command `cd demo-website`.

Run command `mkdir _plugins` in your prompt.

Jekyll loads custom plugins automatically when developers run Jekyll commands in their prompts. Custom plugins should be written in Ruby. All classes loaded by Jekyll can be used directly, and other third-party libraries can be installed by Bundle and imported in Gemfile.

Another way developers import their plugins is by packaging their Ruby programs to gem, and import gems in Gemfile. I recommend you work in this way when you develop a big plugin, otherwise placing your ruby files into the _plugins folder is more comfortable.

## 3. Create a Ruby file in the *_plugins* folder

Run command `touch kramdown-amp.rb` in the *_plugins* folder.

## 4. Create a class inherites from Kramdown::Converter::HTML

Firstly, we create a class named **Amp** inhertes from **Html** in **Kramdown::Converter** module.

Secondly, we only override the `convert_img` method in **Amp** class, and we **DON'T** call it's super method in our new `convert_img` method.

Thirdly, we read the get the width and height of the image we need to insert to the document by the `size` method in **FastImage**. **FastImage** is a light-weight library to read information from a image. You can learn more about [FastImage](https://github.com/sdsykes/fastimage) in its Github repostiory.

Next, we do different when display GIF and other kinds of pictures. Because Google recommend developer use modern picture formats in web design and development, such as WebP (*.webp), JPEG 2000 (*.jp2), and so on, so we use the fallback feature of AMP Image tags to display PNG, JPG pictures if the browser can not load its corresponsive WebP version picture. And if we need to display a GIF image or animation, we do not use the fallback feature here. Learn more about [Fallback Feature in AMP Image Tags](https://amp.dev/documentation/components/amp-img/#example:-specifying-a-fallback-image) by reading its official document.

Paste the below codes into *kramdown-amp.rb* you just created.

```ruby
require "fastimage"

module Kramdown
    module Converter
        class Amp < Html
            def convert_img(el, indent)
                img_src = el.attr["src"]
                img_src = img_src.slice(1..-1) if img_src.start_with?("/")
                w, h = FastImage.size(img_src)

                if img_src.end_with?(".jpg") || img_src.end_with?(".png")
                    "<amp-img class='border border-secondary' layout='responsive' src='#{el.attr['src']}' alt='#{el.attr['alt']}' width='#{w}' height='#{h}'><amp-img class='border border-secondary' fallback layout='responsive' #{html_attributes(el.attr)} width='#{w}' height='#{h}'></amp-img></amp-img>"
                else
                    "<amp-img class='border border-secondary' layout='responsive' #{html_attributes(el.attr)} width='#{w}' height='#{h}'></amp-img>"
                end
            end
        end
    end
end
```

## 5. Create a class inherites from Jekyll::Converters::Markdown::KramdownParser

In the same Ruby file as the class **Amp** we just created, we create another class named **MyCustomerProcessor** inherites from **Jekyll::Converters::Markdown::KramdownParser** in the **Jekyll::Converters::Markdown** module.

**MyCustomerProcessor** class is the plugin class, the only difference from its parent class is invoking `to_amp` method to generate the final HTML codes in the method `convert`.

Paste the below codes into *kramdown-amp.rb* you just created.

```ruby
class Jekyll::Converters::Markdown::MyCustomProcessor < Jekyll::Converters::Markdown::KramdownParser

    def initialize(config)
        super(config)
    end

    def convert(content)
        document = Kramdown::Document.new(content, @config)
        html_output = document.to_amp
        if @config["show_warnings"]
            document.warnings.each do |warning|
                Jekyll.logger.warn "Kramdown warning:", warning
            end
        end
        html_output
    end
end
```

## 6. Change the markdown processor to the plugin you just created

Open *_config.yml* in the root directory of your website, and find the line contains **kramkdown**, and change it like this:

```yml
# Build settings
markdown: MyCustomProcessor
```

## 7. Create a markdown file using the post layout

Run command `touch 2019-12-25-amp-img.md` in the *_posts* folder.

Suppose we placed a image named *image.jpg* in *assets* folder.

**Note**: I suggest an efficient and effective practice to manage images in posts in [Effective Jekyll Content Management: Image Assets in Posts](/effective-jekyll-content-management-image-assets-in-posts.html), and the demo in this article follow that.

Paste the below codes into *2019-12-25-amp-img.md*.

```markdown
---
layout: post
title: amp-img tags
date: 2019-12-25 00:00:00 +08:00:00
---

![Image](/assets/2019-12-25-amp-img/image.jpg)
```

## 8. Install third party dependencies

Open *Gemfile* in the root directory of your website, and append `gem "fastimage"` into it.

We use *FastImage* to get the width and height of the image.

Run command `bundle install` to install all dependencies we need.

## 9. Build your website

Run command `jekyll build` to generate the final HTML website.

Jekyll creates a *_site* folder in the root directory of your website, and all HTML files are saved in it.

## 10. Verify the final HTML

Open *_site/2019/12/amp-img.html*, and you can find no `img` tag in it, and `amp-img` insteads.

*My blog you are reading is an excellent practice of AMP Pages in Jekyll, and you can find its code in my [Github repository](https://github.com/miguoliang/miguoliang.github.io.git).*

## Conclusion

AMP components are robust, well-tested, and SEO friendly. Google recommends AMP Pages in modern website design and development. To Lazy-load images is essential for the website performance, and we can use AMP image tags (`amp-img`) without scripts.
