module CLIHelpers

  def set_descriptions(descs)
    write_data_file(:descriptions, descs)
  end

  def set_subscribers(subs)
    write_data_file(:subscribers, subs)
  end

  def set_posters(posters)
    write_data_file(:posters, posters)
  end

  def set_topics(topics)
    write_data_file(:topics, topics)
  end

  def write_data_file(file, lines)
    write_file("data/#{file}.txt", lines.push('').join("\n"))
  end

  def show_stdout
    @puts = true
    @announce_stdout = true
  end

  def show_stderr
    @puts = true
    @announce_stderr = true
  end

  def output_text
    all_output.chomp
  end

end
