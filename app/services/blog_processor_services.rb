module BlogProcessorServices
  class << self

    def check_error(blog)
      if blog.valid?
        blog.save
        message = yield
      else
        status = 422
        message = blog.errors.messages
      end
      return message, status
    end

  end
end