<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
  <title>Underscore.lua</title>
  <link rel="stylesheet" href="main.css" type="text/css" />
  <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/-->
</head>

<body>
  <div id="container">
    <!-- <div id="main"> -->
      <!-- <div id="content"> -->
        <h1>Underscore.lua</h1>

        <%if file_doc.description then%>
        <p><%=file_doc.description%></p>
        <%end%>
        <p>
          Underscore.lua is a Lua library that provides a set of utility functions for dealing with
          iterators, arrays, tables, and functions. It is <b>heavily</b> inspired by 
          <a href="http://documentcloud.github.com/underscore">Underscore.js</a>. Although the code was
          not referenced during the writing of this library the documentation, examples, and api are basically
          ripped off from them.
        </p>
        
        <h2>Installing</h2>
        <p>The source code is available at <a href="http://github.com/mirven/underscore.lua">available at Github</a>.
        <p>It can be installed with <a href="http://www.luarocks.org">LuaRocks</a> via <code>luarocks install underscore.lua --from=http://marcusirven.s3.amazonaws.com/rocks/</code></p>
        <p>Alternatively underscore.lua can be downloaded directly from <a href="http://github.com/mirven/underscore.lua/raw/0.2-1/lib/underscore.lua">here</a>.</p>
        
        <h2>Object-Oriented and Functional Styles</h2>
        <p>
          You can use Underscore in either an object-oriented or a functional style, 
          depending on your preference. The following two lines of code are identical 
          ways to double a list of numbers.
        </p>
        <pre>
          _.map({1, 2, 3}, function(n) return n * 2 end)
          _({1, 2, 3}):map(function(n) return n * 2 end)
        </pre>
        <p>
          Using the object-oriented style allows you to chain together methods. Calling chain on a 
          wrapped object will cause all future method calls to return wrapped objects as well. When 
          you've finished the computation, use value to retrieve the final value. Here's an example 
          of chaining together a map/flatten/reduce, in order to get the word count of every word in a song.
        </p>
        <pre>
          local lyrics = {
            { line = 1, words = "I'm a lumberjack and I'm okay" },
            { line = 2, words = "I sleep all night and I work all day" },
            { line = 3, words = "He's a lumberjack and he's okay" },
            { line = 4, words = "He sleeps all night and he works all day" }
          }
          
          _(lyrics):chain()
            :map(function(line) 
              local words = {}
              for w in line.words:gmatch("%S+") do
                words[#words+1] = w   
              end
              return words
            end)
            :flatten()
            :reduce({}, function(counts, word)
              counts[word] = (counts[word] or 0) + 1
              return counts
            end):value()
        </pre>
        <p>Note: This can be written even more succinctly as (notice the map function):</p> 
        <pre>
          _(lyrics):chain()
            :map(function(line) return _.to_array(line.words:gmatch("%S+")) end)
            :flatten()
            :reduce({}, function(counts, word)
              counts[word] = (counts[word] or 0) + 1
              return counts
            end):value()
        </pre>
          
        <%if #file_doc.functions > 0 then%>
        <h2>Functions</h2>
        <table class="function_list">
          <%for _, func_name in ipairs(file_doc.functions) do
            local func_data = file_doc.functions[func_name]%>
            <tr>
              <td class="name" nowrap><%=func_data.private and "local " or ""%><a href="#<%=func_name%>"><%=func_name%></a>&nbsp;(<%=table.concat(func_data.param, ", ")%>)</td>
              <td class="summary"><%=func_data.summary%></td>
            </tr>
            <%end%>
          </table>
          <%end%>

          <%if #file_doc.tables > 0 then%>
          <h2>Tables</h2>
          <table class="table_list">
            <%for _, tab_name in ipairs(file_doc.tables) do%>
            <tr>
              <td class="name" nowrap><a href="#<%=tab_name%>"><%=tab_name%></a></td>
              <td class="summary"><%=file_doc.tables[tab_name].summary%></td>
            </tr>
            <%end%>
          </table>
          <%end%>

          <%if #file_doc.functions > 0 then%>
          <h2><a name="functions"></a>Functions</h2>
          <dl class="function">
            <%for _, func_name in ipairs(file_doc.functions) do%>
            <%=luadoc.doclet.html.include("function.lp", { doc=doc, file_doc=file_doc, func=file_doc.functions[func_name] })%>
            <%end%>
          </dl>
          <%end%>

          <%if #file_doc.tables > 0 then%>
          <h2><a name="tables"></a>Tables</h2>
          <dl class="table">
            <%for _, tab_name in ipairs(file_doc.tables) do%>
            <%=luadoc.doclet.html.include("table.lp", { doc=doc, file_doc=file_doc, tab=file_doc.tables[tab_name] })%>
            <%end%>
          </dl>
          <%end%>

        <!-- </div> --> <!-- id="content" -->

      <!-- </div> --> <!-- id="main" -->

    </div> <!-- id="container" -->	
  </body>
</html>
