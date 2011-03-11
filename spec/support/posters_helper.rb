module PostersHelper
  Struct.new("Poster", :uid, :topic, :line)

  def poster_line(uid, topic)
    Struct::Poster.new(uid, topic, "#{uid}:dartmouth.bulletins.#{topic}")
  end

end
