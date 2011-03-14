module CLIHelpers

  def set_descriptions(descs)
    write_file("data/descriptions.txt", descs.push('').join("\n"))
  end

  def set_posters(posters)
    write_file("data/posters.txt", posters.push('').join("\n"))
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
