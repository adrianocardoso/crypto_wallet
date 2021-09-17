namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop:_unsafe) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em modo de desenvolvimento!"
    end
  end
  
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
            { 
              description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://i.pinimg.com/280x280_RS/b3/5d/9a/b35d9a70b107d25f7fa6733e39a64a44.jpg",
              mining_type: MiningType.find_by(acronym: "PoW")
            },
            { 
              description: "Ethereum",
              acronym: "ETH",
              url_image: "https://www.digitalhot.com.br/wp-content/uploads/2017/07/O-que-e-ethereum.png",
              mining_type: MiningType.all.sample
            },
            { 
              description: "Dash",
              acronym: "DASH",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
              mining_type: MiningType.all.sample
            },
            { 
              description: "Iota",
              acronym: "IOT",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
              mining_type: MiningType.all.sample
            },
            { 
              description: "ZCash",
              acronym: "ZEC",
              url_image: "https://www.cryptocompare.com/media/351360/zec.png",
              mining_type: MiningType.all.sample
            }
          ]
      
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]
      
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end
  
  private
  
  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
