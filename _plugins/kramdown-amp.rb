require "fastimage"

module Kramdown
    module Converter
        class Amp < Html
            def convert_img(el, indent)
                img_src = el.attr["src"]
                img_src = img_src.slice(1..-1) if img_src.start_with?("/")
                w, h = FastImage.size(img_src)
                ad = '<amp-ad layout="fixed-height" style="margin-bottom: 1rem;"
                    height="100"
                    type="adsense"
                    data-ad-client="ca-pub-8962113707459496"
                    data-ad-slot="2828171643">
                </amp-ad>';

                if img_src.end_with?(".jpg") || img_src.end_with?(".png")
                    "<amp-img class='border border-secondary' layout='responsive' src='#{el.attr['src']}' alt='#{el.attr['alt']}' width='#{w}' height='#{h}'><amp-img class='border border-secondary' fallback layout='responsive' #{html_attributes(el.attr)} width='#{w}' height='#{h}'></amp-img></amp-img>#{ad}"
                else
                    "<amp-img class='border border-secondary' layout='responsive' #{html_attributes(el.attr)} width='#{w}' height='#{h}'></amp-img>#{ad}"
                end
            end
        end
    end
end

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