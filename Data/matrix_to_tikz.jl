using LinearAlgebra

Nions = 12;

M = rand(Nions,Nions)
open(file, "w") do f
    first_line = prod(["(0 $i 0) (0 $i 0) " for i=1:Nions+1])
    write(f, first_line)
    for i=1:Nions
        for j=1:Nions
            mij = M[i,j]
            ul = "($i $j $mij)"
            ur = "($(i+1) $j $mij)"
            ll = "($i $(j+1) $mij)"
            lr = "($(i+1) $(j+1) $mij)"
            bar = ul*" "*ur*" "*ll*" "*lr
            write(f, bar)
        end
        write(f, "\n\n")
    end
    last_line = prod(["($i 0 0) ($i 0 0) " for i=1:Nions+1])
    write(f, last_line)
end



M = Int.(floor.(10*rand(Nions,Nions)))
open("test_exp.txt", "w") do f
    first_line = prod(["(0,$i,0) (0,$i,0) " for i=0:Nions])
    write(f, chop(first_line, tail=1))
    write(f, "\n\n")
    for i=0:Nions-1
        line_upper = "($i,0,0) "
        line_lower = "($(i+1),0,0) "
        for j=0:Nions-1
            mij = M[i+1,j+1]
            ul = "($i,$j,$mij) "
            ur = "($i,$(j+1),$mij) "
            ll = "($(i+1),$(j),$mij) "
            lr = "($(i+1),$(j+1),$mij) "
            line_upper *= ul*ur
            line_lower *= ll*lr
        end
        line_upper *= "($i,$Nions,0) "
        line_lower *= "($(i+1),$Nions,0) "
        write(f, chop(line_upper, tail=1))
        write(f, "\n\n")
        write(f, chop(line_lower, tail=1))
        write(f, "\n\n")
    end
    last_line = prod(["($Nions,$i,0) ($Nions,$i,0) " for i=0:Nions])
    write(f, chop(last_line, tail=1))
end