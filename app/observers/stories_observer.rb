class StoriesObserver

  def initialize
    config = Rails.configuration.database_configuration
    pg = PGconn.connect(dbname: config[Rails.env]["database"])
    client = Faye::Client.new('http://127.0.0.1:3000/faye')
    pg.exec "LISTEN stories_insert;"
    pg.exec "LISTEN stories_update;"
    pg.exec "LISTEN stories_delete;"

    EM.next_tick do
      EM.watch(pg.socket, Subscriber, pg, client) { |c| c.notify_readable = true }
    end
  end

end

module Subscriber
  def initialize(pg, faye)
    @pg = pg
    @faye = faye
  end

  def notify_readable

    @pg.consume_input

    while notification = @pg.notifies
      puts '#YOLO'
      if notification[:relname] =~ /_insert$/
        @faye.publish('/stories', type: 'created', data: notification[:extra])
      elsif notification[:relname] =~ /_update$/
        @faye.publish('/stories', type: 'updated', data: notification[:extra])
      elsif notification[:relname] =~ /_delete$/
        @faye.publish('/stories', type: 'deleted', data: notification[:extra])
      end
    end
  end

  def unbind
    @pg.close
  end
end
