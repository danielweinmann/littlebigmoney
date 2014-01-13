class Configuration < ActiveRecord::Base
  validates_presence_of :name
  
  def self.update_configurations!
    self.update_paypal_conversion!
  end
  
  def self.update_paypal_conversion!
    page = Nokogiri::HTML(HTTParty.get("http://www.superfinanciera.gov.co/Cifras/informacion/diarios/tcrm/tcrm.htm").body)
    
    mean = 0
    volatility = 0

    page.search("table").search("tr").each do |row|
      variable = row.search("td")[0]
      variable = variable.text.strip if variable
      value = row.search("td")[2]
      value = value.text.strip if value
      if variable == 'Promedio Ponderado de Venta'
        mean = value.gsub(',', '').to_f
      elsif variable == 'Volatilidad de la TCRM (%)'
        volatility = value.gsub('%', '').to_f / 100
      end
    end
    
    if mean != 0 && volatility != 0
      conversion = ((mean - mean * volatility) * 100).round.to_f / 100
      Configuration[:paypal_currency] = "USD"
      Configuration[:paypal_conversion] = conversion
    end
    
  end
  
  class << self
    # This method returns the values of the config simulating a Hash, like:
    #   Configuration[:foo]
    # It can also bring Arrays of keys, like:
    #   Configuration[:foo, :bar]
    # ... so you can pass it to a method using *.
    # It is memoized, so it will be correctly cached.
    def [] *keys
      if keys.size == 1
        get keys.shift
      else
        keys.map{|key| get key }
      end
    end
    def []= key, value
      set key, value
    end
    private

    def get key
      find_by_name(key).value rescue nil
    end

    def set key, value
      begin
        find_by_name(key).update_attribute :value, value
      rescue
        create!(name: key, value: value)
      end
      value
    end

  end
end
