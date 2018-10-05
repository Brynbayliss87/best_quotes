class QuotesController < Rulers::Controller
  def a_quote
    @quote = "passed variable"
    render :a_quote, noun: :winking
  end
end
