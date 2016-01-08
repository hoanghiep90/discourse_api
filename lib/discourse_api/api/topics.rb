module DiscourseApi
  module API
    module Topics
      # :category OPTIONAL name of category, not ID
      # :skip_validations OPTIONAL boolean
      # :auto_track OPTIONAL boolean
      def create_topic(args)
        args = API.params(args)
                  .required(:title, :raw, :tags, :stars)
                  .optional(:skip_validations, :category, :auto_track)
        post("/posts", args.to_h)
      end

      def latest_topics(params={})
        response = get('/latest.json', params)
        response[:body]['topic_list']['topics']
      end

      def new_topics(params={})
        response = get("/new.json", params)
        response[:body]['topic_list']['topics']
      end

      def rename_topic(topic_id, title, tags)
        put("/t/#{topic_id}.json", { topic_id: topic_id, title: title, tags: tags })
      end

      def update_stars(topic_id, stars)
        put("/t/#{topic_id}.json", { topic_id: topic_id, stars: stars })
      end

      def update_with_created_date(topic_id, created_date)
        put("/t/#{topic_id}.json", { topic_id: topic_id, created_date: created_date })
      end

      def recategorize_topic(topic_id, category_id)
        put("/t/#{topic_id}.json", { topic_id: topic_id, category_id: category_id })
      end

      def topic(id, params={})
        response = get("/t/#{id}.json", params)
        response[:body]
      end

      def topics_by(username, params={})
        response = get("/topics/created-by/#{username}.json", params)
        response[:body]['topic_list']['topics']
      end

      def delete_topic(id)
        delete("/t/#{id}.json")
      end

      def update_content_topic(topic_id,content,tags)
        put("/t/#{topic_id}.json", {topic_id: topic_id,excerpt: content,tags: tags})
      end
    end
  end
end
