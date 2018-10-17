class QuotesController < Rulers::Controller

  def index
    quotes = FileModel.all
    render :index, quotes: quotes
  end

  def a_quote
    @quote = "passed variable"
    render :a_quote, noun: :winking
  end

  def quote_1
    quote_1 = FileModel.find(1)
    render :quote, obj: quote_1
  end

  def new_quote
    attrs = {
     submitter: "me",
      quote: "scoobedy doo dop",
      attribution: "The Scat Man"
    }

    m = FileModel.create attrs
    render :quote, obj: m
  end

  def update
    return unless env["REQUEST_METHOD"] == "POST"
    model = "db/quotes/#{params["id"]}.json"
    hash = MultiJson.load("#{File.read(model)}")
    hash.each do |key, value|
      hash[key] = params[key] if params.has_key?(key)
    end
    hash = MultiJson.dump(hash)
    File.open(model, "w") do |f|
      f.write(hash)
    end
  end

  def show
    p params
    quote = FileModel.find(params["id"])
    render :quote, obj: quote
  end
end
