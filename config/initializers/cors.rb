Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do 
    origins "http://localhost:3000"
    resource "*", headers: :any, methods: [:get, :post], credentials: true
  end

  allow do 
    origins "http://127.0.0.1:5500"
    resource "*", headers: :any, methods: [:get, :post], credentials: true
  end

  allow do 
    origins "https://patrickrgrady81.github.io/Snake"
    resource "*", headers: :any, methods: [:get, :post], credentials: true
  end

  allow do 
    origins "http://127.0.0.1:5500/?"
    resource "*", headers: :any, methods: [:get, :post], credentials: true
  end

  allow do 
    origins "https://https://paddysnake.herokuapp.com/"
    resource "*", headers: :any, methods: [:get, :post], credentials: true
  end
end

