module Annotator

export @beginAnnotate, @Annotate_str, @endAnnotate

macro beginAnnotate(filename)
    global __ADOC__filename = filename
    global __ADOC__= []
    push!(__ADOC__,__source__.line)
end
macro Annotate_str(str)
    if @isdefined __ADOC__
        push!(__ADOC__,__source__.line)
        push!(__ADOC__,str)
        push!(__ADOC__,1+__source__.line+length(collect(eachmatch(r"\n",str))))
    end
end
macro endAnnotate()
    function read_nth_lines(stream,first,last)
        for i = 1:first
            readline(stream)
        end
        result = []
        for i = first+1:last-1
            push!(result,readline(stream))
        end
        return result
    end
    if @isdefined __ADOC__
        push!(__ADOC__,__source__.line)
        output = open(__ADOC__filename*".tex","w")
        codeblock = -1
        if __ADOC__[1] + 1 == __ADOC__[2]
            popfirst!(__ADOC__)
            popfirst!(__ADOC__)
        end
        if __ADOC__[end-1]+1 == __ADOC__[end]
            pop!(__ADOC__)
            pop!(__ADOC__)
        end
        for item = __ADOC__
            if typeof(item) == String
                write(output,item*"\n")
            elseif typeof(item) == Int
                if codeblock == -1
                    codeblock = item
                else
                    write(output,"\\begin{lstlisting}\n")
                    self = open(string(__source__.file),"r")
                    codelines = read_nth_lines(self,codeblock,item)
                    close(self)
                    for line = codelines
                        write(output,line*"\n")
                    end
                    write(output,"\\end{lstlisting}\n\n")
                    codeblock = -1
                end
            end
        end
        close(output)
    end
end
end
