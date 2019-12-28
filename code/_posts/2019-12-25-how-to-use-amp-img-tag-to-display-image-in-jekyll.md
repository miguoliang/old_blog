---
layout: post
title: How to use amp-img tag to display image in Jekyll
description: You will learn how to build a custom plugin to generate amp-img tag instead of img tag in Jekyll.
image: /assets/2019-12-25-how-to-use-amp-img-tag-to-display-image-in-jekyll/banner.jpg
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

Run command `mkdir _plugins` in your prompt.

Jekyll loads custom plugins automatically when developers run Jekyll commands in their prompts. Custom plugins should be written in Ruby. All classes loaded by Jekyll can be used directly, and other third-party libraries can be installed by Bundle and imported in Gemfile.

Another way developers import their plugins is by packaging their Ruby programs to gem, and import gems in Gemfile. I recommend you work in this way when you develop a big plugin, otherwise placing your ruby files into the _plugins folder is more comfortable.

## 3. Create a Ruby file in the *_plugins* folder

Run command `touch kramdown-amp.rb` in the *_plugins* folder.

## 4. Create a class inherites from Kramdown::Converter::HTML

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
