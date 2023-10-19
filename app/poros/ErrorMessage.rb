class ErrorMessage
  attr_reader :message,
              :status

  def initialize(error_message, status_code)
    @message = error_message
    @status = status_code
  end
end