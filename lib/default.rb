module PostHelper
    def get_pretty_date(post)
        attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
    end

    def get_begin_of_post(post)
        content = post.compiled_content

        if content =~ /\s<!-- preview_end -->\s/
            content = content.partition('<!-- preview_end -->').first
        end

        if content =~ /\s<!-- preview_start -->\s/
            content = content.partition('<!-- preview_start -->').last
        end

        return content
    end
end

module AppHelper
    def get_apps()
        return items.select { |item| item[:kind] == "app" }
    end

    def get_app_with_identifier(identifier)
        return get_apps().bsearch { |app| app[:app_identifier] == identifier }
    end

    def get_app_description(app)
        content = app.compiled_content

        if content =~ /\s<!-- description_end -->\s/
            content = content.partition('<!-- description_end -->').first
        end

        if content =~ /\s<!-- description_start -->\s/
            content = content.partition('<!-- description_start -->').last
        end

        return content
    end
end

def flatten_all_categories
    @items.each do |item|
        item[:categories] = flattened_categories(item[:categories])
    end
end

def flattened_categories(categories)
    if categories.nil?
        [ ]
    elsif categories.respond_to?(:each)
        categories
    elsif categories.include?(',')
        categories.split(/\s*,\s*/)
    else
        [ categories ]
    end
end

def all_categories
    categories = []
    sorted_articles.each do |item|
        next if item[:categories].nil?
        if item[:categories].respond_to?(:each)
            item[:categories].each { |category| categories << category }
        else
            categories << item[:categories]
        end
    end
    categories.uniq
end

def create_categories
    for category in all_categories
        puts category
        # @items.create(
        #     "<%= render 'category', :category => \"#{category}\" %>",
        #     { :title => category },
        #     "/blog/category/#{category}/"
        # )
    end
end

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo
include PostHelper
include AppHelper
