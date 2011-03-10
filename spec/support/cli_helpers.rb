module CLIHelpers

  def show_stdout
    @puts = true
    @announce_stdout = true
  end

  def show_stderr
    @puts = true
    @announce_stderr = true
  end

end
