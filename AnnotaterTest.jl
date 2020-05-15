push!(LOAD_PATH, pwd())
using Annotator
@beginAnnotate("out")
Annotate"""
This simple module allows you to practice Donald Knuth's Literate Programming in Julia.
To Start, Just use the ``@startAnnotate macro'', and when run, the program will start the process
of compiling your annotations.
"""
function pointless(fortesting)
    return nothing
end
Annotate"""
To add commentary, simply use the @commentary command, and then
write whatever you have to say in \LaTeX format
"""
function simpleTest()
    return nothing
end
Annotate"""
Then, when you're done, simply call the ``@endAnnotate'' macro, and watch the magic.
"""
@endAnnotate()
