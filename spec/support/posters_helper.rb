module PostersHelper
  Struct.new("Poster", :uid, :topic, :line)
  Struct.new("Profile", :name, :expires)

  def poster_line(uid, topic)
    Struct::Poster.new(uid, topic, "#{uid}:dartmouth.bulletins.#{topic}")
  end

  def mock_profile(name, expires)
    Struct::Profile.new(name, expires)
  end

end
