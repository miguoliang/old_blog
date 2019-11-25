require "fastimage"

module Kramdown
    module Converter
        class Amp < Html
            def convert_img(el, indent)
                img_src = el.attr["src"]
                img_src = img_src.slice(1..-1) if img_src.start_with?("/")

                if img_src.end_with?(".jpg") || img_src.end_with?(".png")
                    "<amp-img layout='container' src='#{el.attr['src']}' alt='#{el.attr['alt']}' width='535' height='300'><amp-img#{html_attributes(el.attr)} width='535' height='300'></amp-img></amp-img>"
                else
                    "<amp-img layout='container' #{html_attributes(el.attr)} width='535' height='300' layout='responsive'></amp-img>"
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