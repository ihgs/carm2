require 'smartcard'
require 'json'
require 'net/http'
require 'uri'


class MyCardReader

  def queries
    unless @queries
      @queries = Smartcard::PCSC::ReaderStateQueries.new(1)
      @queries[0].current_state = :empty
      @queries[0].reader_name = reader
    end
    return @queries
  end

  def reader
    unless @reader
      readers = context.readers
      @reader = readers.first
    end
    @reader
  end

  def context
    unless @context
      @context = Smartcard::PCSC::Context.new
    end
    return @context
  end

  def waiting_insert_card &block
    context.wait_for_status_change(queries)
    queries.ack_changes
    if current_state.include? :present
      card_id = get_id
      if current_state.include? :inuse
        yield
      end
    end
  end

  def current_state
    return queries[0].current_state
  end

  def get_id
    card = Smartcard::PCSC::Card.new(context, reader, :shared)
    response = card.transmit([0xFF, 0xCA, 0x00, 0x00, 0x00].pack('C*'))
    return response.unpack('H*').first #TODO 動作未確認
  end

  def release
    @context.release
    @context = nil
    @reader = nil
    @queries = nil
  end
end


r = MyCardReader.new

url = "http://127.0.0.1:3000/api/stamp/"
uri = URI.parse(url)


while true
  r.waiting_insert_card do
    card_id =  r.get_id
    params = {
      "time": Time.now.to_i,
      "card_id": card_id,
      "device_name": r.reader
    }
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    req.body = params.to_json
    res = http.request(req)
    puts res.body
  end
end
