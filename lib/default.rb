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

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo
include PostHelper
include AppHelper
