defmodule Mix.Tasks.Minify do
  use Mix.Task

  def run(_) do
    Mix.shell.info "Minifying plug-ribbon.css ..."
    :os.cmd('curl -X POST -s --data-urlencode "input@priv/static/plug-ribbon.css" http://cssminifier.com/raw > "priv/static/plug-ribbon.min.css"')
    Mix.shell.info "Minifying plug-ribbon.ie.css ..."
    :os.cmd('curl -X POST -s --data-urlencode "input@priv/static/plug-ribbon.ie.css" http://cssminifier.com/raw > "priv/static/plug-ribbon.ie.min.css"') 
    Mix.shell.info "Completed minify task"
  end
end

