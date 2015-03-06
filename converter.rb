require 'csv'

SourceRow = Struct.new(:account_number, :currency, :current_balance, :available_balance, :posting_date, :value_date, :type, :description, :debit, :credit, :running_balance) do
  def amount
    a = debit ? debit : credit
    a.gsub!(',', '')
    a = Float(a)
    a = a * -1 if debit
    a
  end

  def name
    description.gsub(/\r\n/, ' ').strip
  end
end

class Converter
  def self.call(source_file, target_file)
    CSV.open(target_file, 'wb') do |csv|
      CSV.foreach(source_file) do |row|
        source = SourceRow.new(*row)
        csv << [source.posting_date, source.amount, source.name]
      end
    end
  end
end

Converter.call(ARGV[0], ARGV[1])

