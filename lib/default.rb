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

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo
include PostHelper
