module Jekyll
    module ImageSizeFilter
        def image_size(input, arg1)
            input.gsub(/\.jpg$/, "-#{arg1}.jpg")
        end
    end
end

Liquid::Template.register_filter(Jekyll::ImageSizeFilter)