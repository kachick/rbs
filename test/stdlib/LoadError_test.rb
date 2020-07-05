require_relative "test_helper"
require "tempfile"

class LoadErrorTest < StdlibTest
  target LoadError

  def test_path
    Tempfile.open(['rbs', 'rb']) do |tf|
      path = tf.path
      tf.unlink
      require path
      raise
    rescue LoadError => exception
      exception.path
    end

    begin
      eval('require_relative ""')
      raise
    rescue LoadError => exception
      exception.path
    end
  end
end
