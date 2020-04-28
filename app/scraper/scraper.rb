class Scraper

    @@all = []

        switch_url = "https://www.gamestop.com/video-games/switch"
        unparsed_switch_page = HTTParty.get(switch_url)
        parsed_switch_page = Nokogiri::HTML(unparsed_switch_page)
        switch = parsed_switch_page.css(".product-tile-header .pdp-link")

        switch.each do |switch_title|
            @@all << switch_title.text.strip
        end


        ps_url = "https://www.gamestop.com/video-games/playstation-4"
        unparsed_ps_page = HTTParty.get(ps_url)
        parsed_ps_games = Nokogiri::HTML(unparsed_ps_page)
        ps = parsed_ps_page.css(".product-tile-header .pdp-link")

        ps.each do |ps_title|
            @@all << ps_title.text.strip
        end



        xbox_url = "https://www.gamestop.com/video-games/xbox-one/games"
        unparsed_xbox_page = HTTParty.get(xbox_url)
        parsed_xbox_page = Nokogiri::HTML(unparsed_xbox_page)
        xbox = parsed_page.css(".product-tile-header .pdp-link")

        xbox.each do |xbox_title|
            @@all << xbox_title.text.strip
        end


end

# Playstation 4/Switch Game Titles
# parsed_page.css(".product-tile-header .pdp-link")[0].text.strip

